var app = new Vue({
    el: '#app',
    data: {
        materia: '',
        materias: []
    },
    methods: {
        cargar: function (){
            var aux = []
            fetch('http://localhost/encuestaVue/materias')
                .then(status)
                .then(json)
                .then(function(data) {
                    data.materias.records.forEach(function (m){
                        aux.push(m[1])
                    })
                })
                .catch(function(err) {
                    console.log('Request failed', err)
                })
            this.materias = aux
        },
        insert: function () {
            var obj = {nombre: this.materia}
            fetch('http://localhost/encuestaVue/materias',
                {
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    },
                    method: "POST",
                    body: JSON.stringify(obj)
                })
                .then(json)
                .then(function (data) {
                    console.log('Request succeeded with JSON response', data);
                })
                .catch(function (error) {
                    console.log('Request failed', error);
                })
            this.cargar()
        }
    }
})

// FUNCIONES AUXILIARES
function status(response) {
    if (response.status >= 200 && response.status < 300) {
        return Promise.resolve(response)
    } else {
        return Promise.reject(new Error(response.statusText))
    }
}

function json(response) {
    return response.json()
}