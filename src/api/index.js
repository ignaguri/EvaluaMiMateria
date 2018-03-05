import axios from 'axios'
const URL = process.env.API_URL

export default {
  test () {
    return axios.get(URL + 'api.php')
      .then(response => {
        return response
      })
  },
  checkLogin () {
    return sessionStorage.getItem('userId')
  },
  authorized (rol) {
    return Number(sessionStorage.getItem('rol')) === rol
  },
  login (data) {
    return axios.get(URL + 'usuarios' + '?filter=legajo,eq,' + data.legajo)
      .then(function (response) {
        // console.log(response.data)
        if (response.data.usuarios.records.length <= 0) {
          console.error('Usuario no encontrado')
          return [false, 'Usuario no encontrado']
        }
        if (response.data.usuarios.records[0][5] !== data.pass) {
          console.error('Contraseña incorrecta')
          return [false, 'Contraseña incorrecta']
        }
        sessionStorage.setItem('userId', response.data.usuarios.records[0][0])
        sessionStorage.setItem('nombre', response.data.usuarios.records[0][3])
        sessionStorage.setItem('rol', response.data.usuarios.records[0][6])
        return [true, response.data.usuarios.records[0][0], response.data.usuarios.records[0][6]]
      })
      .catch(function (error) {
        console.log(error)
        return [false, error]
      })
  },
  getNombreLogged () {
    return sessionStorage.getItem('nombre')
  },
  dbArrayToObject (data) {
    let aux = []
    if (data.records.length > 0) {
      const cols = data.columns
      data.records.forEach(m => {
        let e = {}
        for (let i = 0; i < cols.length; i++) {
          e[cols[i]] = m[i]
        }
        aux.push(e)
      })
      return aux
    } else {
      return false
    }
  },
  dbItemToObject (data) {
    let aux = []
    console.log('item to ob', data)
    if (data.records.length > 0) {
      const cols = data.columns
      data.records.forEach(m => {
        let e = {}
        for (let i = 0; i < cols.length; i++) {
          e[cols[i]] = m[i]
        }
        aux.push(e)
      })
      return aux
    } else {
      return false
    }
  },
  getMaterias () {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    return axios.get(URL + 'materias')
      .then(function (response) {
        return response.data.materias
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  getMateria (id) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    return axios.get(URL + 'materias/' + id)
      .then(function (response) {
        return response.data
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  postMaterias (materia) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    return axios.post(URL + 'materias', materia)
      .then(function (response) {
        return true
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  registrar (user) {
    return axios.post(URL + 'usuarios', user)
      .then(function (response) {
        if (response.data) return true
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  getEncuestas () {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    return axios.get(URL + 'encuestas')
      .then(function (response) {
        return response.data.encuestas
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  getEncuestasFull () {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    return axios.get(URL + 'encuestas')
      .then(r => {
        return this.dbArrayToObject(r.data.encuestas)
      })
      .then(data => {
        let promesas = []
        data.forEach(encuesta => {
          promesas.push(this.populateEncuesta(encuesta))
        })
        return Promise.all(promesas)
      })
      .then(fin => {
        return fin
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  getEncuestaFull (id) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    return axios.get(URL + 'encuestas/' + id)
      .then(r => {
        // return this.dbItemToObject(r.data)
        // let promesas = []
        // data.forEach(encuesta => {
        //   promesas.push(this.populateEncuesta(encuesta))
        // })
        // return Promise.all(promesas)
        return this.populateEncuesta(r.data)
      })
      .then(fin => {
        return fin
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  populateEncuesta (e) {
    return this.getUsuario(e.creador)
      .then(user => {
        e.creador = user.nombre + ', ' + user.apellido
        return this.getCurso(e.curso)
      })
      .then(curso => {
        e.curso = curso.nombre + '(' + curso.turno + ')'
        return this.getMateria(e.materia)
      })
      .then(materia => {
        e.materia = materia.nombre
        return this.getEtapa(e.etapaActual)
      })
      .then(etapa => {
        e.etapaActual = etapa.nombre
        return e
      })
  },
  getCursos () {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    return axios.get(URL + 'curso')
      .then(function (response) {
        return response.data.curso
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  getCurso (id) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    return axios.get(URL + 'curso/' + id)
      .then(function (response) {
        return response.data
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  postEncuesta (encuesta) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    encuesta.creador = this.checkLogin()
    encuesta.etapaActual = 1
    encuesta.fechaCreacion = new Date() // const hoy = new Date().getFullYear() + '-' + (new Date().getMonth() + 1) + '-' + new Date().getDate()
    return axios.post(URL + 'encuestas', encuesta)
      .then(function (response) {
        return true
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  getUsuario (id) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    return axios.get(URL + 'usuarios/' + id)
      .then(function (response) {
        return response.data
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  getEtapa (id) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    return axios.get(URL + 'etapas/' + id)
      .then(function (response) {
        return response.data
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  }
}
