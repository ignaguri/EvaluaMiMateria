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
  }
}
