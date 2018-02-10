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
    return sessionStorage.getItem('user')
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
        sessionStorage.setItem('user', response.data.usuarios.records[0][3])
        return [true, response.data.usuarios.records[0][3]]
      })
      .catch(function (error) {
        console.log(error)
        return [false, error]
      })
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
  }
}
