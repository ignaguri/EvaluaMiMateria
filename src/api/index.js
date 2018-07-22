import axios from 'axios'
axios.defaults.withCredentials = true
// import php_transform from './php_crud_api_transform'
const URL = process.env.API_URL
// TODO: transformar todos los metodos que no usan ?transform=1
export default {
  test () {
    return axios.get(URL + 'api.php')
      .then(response => {
        return response
      })
  },
  checkLogin () {
    // TODO: chequear si algun metodo lo usa sin wrappearlo en Number() para poder devolverlo directamente wrappeado
    return sessionStorage.getItem('userId')
  },
  authorized (rol) {
    return Number(sessionStorage.getItem('rol')) === rol
  },
  login (data) {
    return axios.get(URL + 'usuarios' + '?filter=legajo,eq,' + data.legajo + '&transform=1')
      .then(response => {
        if (response.data.usuarios.length <= 0) {
          console.error('Usuario no encontrado')
          return [false, 'Usuario no encontrado']
        }
        const user = response.data.usuarios[0]
        if (user.password !== data.pass) {
          console.error('Contraseña incorrecta')
          return [false, 'Contraseña incorrecta']
        }
        sessionStorage.setItem('userId', user.idUsuarios)
        sessionStorage.setItem('nombre', user.nombre)
        sessionStorage.setItem('rol', user.idRol)
        return [true, user.idUsuarios, user.idRol]
      })
      .catch(error => {
        console.error(error)
        return [false, error.response.status + ' ' + error.response.statusText]
      })
  },
  logout (ctx) {
    sessionStorage.clear()
    ctx.$router.push('/')
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
  editarPerfil (user) {
    return axios.put(URL + 'usuarios/' + user.id, user)
      .then(r => {
        return r.data
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
  getEncuesta (id) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    return axios.get(URL + 'encuestas/' + id + '?transform=1')
      .then(function (response) {
        return response.data
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  getEncuestaPorCodigo (codigo) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    return axios.get(URL + 'encuestas' + '?filter=codigo,eq,' + codigo + '&transform=1')
      .then(function (response) {
        if (response.data.encuestas.length > 0) {
          return response.data.encuestas[0]
        } else {
          return false
        }
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  getEncuestasFull () {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    // TODO: mejorar, usando la sintaxis de abajo para ahorrarse el populate
    // return axios.get(URL + 'encuestas?include=curso,materias,etapas&transform=1')
    //   .then(r => {
    //     console.log('raw', r.data)
    //     return r.data
    //   })
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
  getEncuestasMatriculado () {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    let alumno = this.checkLogin()
    return axios.get(URL + 'usuariosxencuesta' + '?filter=idUsuario,eq,' + alumno + '&transform=1')
      .then(matriculadas => {
        let encuestas = matriculadas.data.usuariosxencuesta
        let promesas = []
        encuestas.forEach(encuesta => {
          promesas.push(this.getEncuestaFull(encuesta.idEncuesta))
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
  getEncuestasPropietarias () {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    let creador = this.checkLogin()
    return axios.get(URL + 'encuestas' + '?filter=creador,eq,' + creador + '&transform=1')
      .then(creadas => {
        let encuestas = creadas.data.encuestas
        let promesas = []
        encuestas.forEach(encuesta => {
          promesas.push(this.getEncuestaFull(encuesta.idEncuestas))
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
        e.creador = user.apellido + ', ' + user.nombre
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
  },
  cambiarEtapa (idEncuesta, proxEtapa, fechaFin) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    let idEtapa = 1
    switch (proxEtapa) {
      case 'Votación de criterios':
        idEtapa = 2
        break
      case 'Priorización':
        idEtapa = 3
        break
      case 'Habilitada':
        idEtapa = 4
        break
      case 'Cerrada':
        idEtapa = 5
        break
      default:
        console.log('default', proxEtapa)
    }
    return axios.put(URL + 'encuestas/' + idEncuesta, { etapaActual: idEtapa, fechaFinEtapaActual: new Date(fechaFin) })
      .then(r => {
        if (r.data > 0) return true
        else return false
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  etapaAId (etapa) {
    switch (etapa) {
      case 'Votacion Criterios':
        return 2
      case 'Priorizacion':
        return 3
      case 'Habilitada':
        return 4
      case 'Cerrada':
        return 5
      default:
        return false
    }
  },
  generarCodigo (idEncuesta, codigo) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    return axios.put(URL + 'encuestas/' + idEncuesta, { codigo: codigo })
      .then(r => {
        if (r.data > 0) return codigo
        else return false
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  matricularse (codigo) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    let alumno = this.checkLogin()
    return this.getEncuestaPorCodigo(codigo)
      .then(found => {
        if (found) {
          return axios.post(URL + 'usuariosxencuesta', {idEncuesta: found.idEncuestas, idUsuario: alumno})
            .then(r => {
              return true
            })
            .catch(function (error) {
              console.log(error)
              return false
            })
        } else {
          return false
        }
      })
  },
  getCriterio (id) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    return axios.get(URL + 'criteriosxencuesta/' + id + '&transform=1')
      .then(r => {
        return r.data
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  getCriteriosXEncuesta (encuesta) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    return axios.get(URL + 'criteriosxencuesta' + '?filter=idEncuesta,eq,' + encuesta + '&transform=1')
      .then(function (response) {
        return response.data.criteriosxencuesta
      })
      .then(data => {
        let promesas = []
        data.forEach(cxe => {
          promesas.push(this.populateCriterioXEncuesta(cxe))
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
  getCriteriosXEncuestaConVotos (encuesta) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    let criterios = null
    return axios.get(URL + 'criteriosxencuesta' + '?filter=idEncuesta,eq,' + encuesta + '&transform=1')
      .then(function (response) {
        return response.data.criteriosxencuesta
      })
      .then(data => {
        let promesas = []
        data.forEach(cxe => {
          promesas.push(this.populateCriterioXEncuesta(cxe))
        })
        return Promise.all(promesas)
      })
      .then(crit => {
        criterios = crit
        let promesas = []
        crit.forEach(c => {
          promesas.push(this.getVotosCriterio(c.idCriteriosXEncuesta, c.idEncuesta))
        })
        return Promise.all(promesas)
      })
      .then(ccv => {
        criterios.forEach(c => {
          let aux = ccv.find(voto => voto.criterio === c.idCriteriosXEncuesta)
          c.etapaActual = aux.etapaActual
          c.votos = aux.votosxcriterio
        })
        return criterios
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  getCriteriosDefinitivosConVotos (encuesta) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    let criterios
    return axios.get(URL + 'criteriosxencuesta' + '?filter=idEncuesta,eq,' + encuesta + '&transform=1')
      .then(function (response) {
        return response.data.criteriosxencuesta
      })
      .then(data => {
        return data.filter(c => c.esDefinitivo)
      })
      .then(crit => {
        criterios = crit
        let promesas = []
        crit.forEach(c => {
          promesas.push(this.getRespuestasHistoricas(c.idCriteriosXEncuesta))
        })
        return Promise.all(promesas)
      })
      .then(ccv => {
        criterios.forEach(c => {
          let aux = ccv.filter(voto => {
            if (voto !== null) {
              return voto[0].idCriterioXEncuesta === c.idCriteriosXEncuesta
            }
          })
          c.votos = aux[0]
        })
        return criterios
      })
      .then(ccvParsed => {
        let populated = []
        ccvParsed.forEach(c => {
          // let votos = {}
          // c.votos.forEach(voto => {
          //   const rta = voto.respuesta // String(voto.respuesta)
          //   if (votos[rta]) {
          //     votos[rta] += 1
          //   } else {
          //     votos[rta] = 1
          //   }
          // })
          let votos = {
            '5 p': 0,
            '4 p': 0,
            '3 p': 0,
            '2 p': 0,
            '1 p': 0
          }
          c.votos.forEach(voto => {
            const rta = voto.respuesta + ' p'
            votos[rta] += 1
          })
          populated.push({
            idCriterio: c.idCriteriosXEncuesta,
            criterio: c.criterio,
            votos: votos
          })
        })
        return populated
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  getCriteriosDefinitivosConVotosXSemana (encuesta) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    const week = this.getWeekNumber(new Date())
    let criterios
    return axios.get(URL + 'criteriosxencuesta' + '?filter=idEncuesta,eq,' + encuesta + '&transform=1')
      .then(function (response) {
        return response.data.criteriosxencuesta
      })
      .then(data => {
        return data.filter(c => c.esDefinitivo)
      })
      .then(crit => {
        criterios = crit
        let promesas = []
        crit.forEach(c => {
          promesas.push(this.getRespuestasXSemana(c.idCriteriosXEncuesta, week))
        })
        return Promise.all(promesas)
      })
      .then(ccv => {
        criterios.forEach(c => {
          let aux = ccv.filter(voto => {
            if (voto !== null) {
              return voto[0].idCriterioXEncuesta === c.idCriteriosXEncuesta
            }
          })
          c.votos = aux[0]
        })
        return criterios
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  postCriteriosXEncuesta (criterio, encuesta) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    const body = {
      idEncuesta: encuesta,
      criterio: criterio,
      propuestoPor: this.checkLogin(),
      esDefinitivo: false
    }
    return axios.post(URL + 'criteriosxencuesta', body)
      .then(r => {
        return true
      })
      .catch(error => {
        console.log(error)
        return false
      })
  },
  populateCriterioXEncuesta (e) {
    return this.getUsuario(e.propuestoPor)
      .then(user => {
        e.propuestoPor = user.apellido + ', ' + user.nombre
        e.esDefinitivo = e.esDefinitivo !== 0
        return e
      })
  },
  borrarCriterio (id) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    return axios.get(URL + 'criteriosxencuesta/' + id + '&transform=1')
      .then(r => {
        const criterio = r.data
        const userId = Number(this.checkLogin())
        if (criterio.propuestoPor !== userId) {
          alert('Error al borrar. El criterio no fue propuesto por el usuario intentando borrarlo.')
          return false
        }
        return axios.delete(URL + 'criteriosxencuesta/' + id)
      })
      .then(r => {
        return r.data > 0
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  guardarVotacion (criterios, etapa, encuesta) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    const userId = Number(this.checkLogin())
    // BORRAR LOS VOTOS ANTERIORES
    return this.borrarVotos(encuesta, this.etapaAId(etapa), userId)
      .then(borrados => {
        // FIN BORRAR
        // NUEVO VOTO
        const body = []
        criterios.forEach(c => {
          body.push({
            idCriterioXEncuesta: c,
            idUsuarioVotante: userId,
            idEtapaActual: this.etapaAId(etapa)
          })
        })
        if (body.length) {
          return axios.post(URL + 'votosxcriterio', body)
          // FIN NUEVO VOTO
        } else {
          return true
        }
      })
      .then(r => {
        return true
      })
      .catch(error => {
        console.log(error)
        return false
      })
  },
  guardarPriorizacion (criterios, etapa, encuesta) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    const userId = Number(this.checkLogin())
    // BORRAR LOS VOTOS ANTERIORES
    return this.borrarVotos(encuesta, this.etapaAId(etapa), userId)
      .then(borrados => {
        // FIN BORRAR
        // NUEVO VOTO
        const body = []
        criterios.forEach(c => {
          body.push({
            idCriterioXEncuesta: c.id,
            priorizacion: c.priorizado,
            idUsuarioVotante: userId,
            idEtapaActual: this.etapaAId(etapa)
          })
        })
        if (body.length) {
          return axios.post(URL + 'votosxcriterio', body)
          // FIN NUEVO VOTO
        } else {
          return true
        }
      })
      .then(r => {
        return true
      })
      .catch(error => {
        console.log(error)
        return false
      })
  },
  getVotosCriterio (criterio, encuesta) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    let etapa = null
    return this.getEncuesta(encuesta)
      .then(enc => {
        etapa = enc.etapaActual
        return axios.get(URL + 'votosxcriterio' +
          '?filter[]=idCriterioXEncuesta,eq,' + criterio +
          '&filter[]=idEtapaActual,eq,' + etapa +
          '&satisfy=all' + '&transform=1')
      })
      .then(response => {
        response.data.etapaActual = etapa
        response.data.criterio = criterio
        return response.data
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  getVotosXUser (etapa, user) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    return axios.get(URL + 'votosxcriterio' +
      '?filter[]=idEtapaActual,eq,' + etapa +
      '&filter[]=idUsuarioVotante,eq,' + user +
      '&satisfy=all' + '&transform=1')
      .then(function (response) {
        return response.data.votosxcriterio
      })
      .then(v => {
        if (v.length > 0) {
          return v
        } else {
          return null
        }
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  borrarVotos (encuesta, etapa, user) {
    let votosViejos = null
    return this.getVotosXUser(etapa, user)
      .then(r => {
        if (!r) throw Error('cool')
        votosViejos = r
        // con r.idCriterioXEncuesta buscar el id encuesta y borrar solo los que coincidan con la actual
        let promesas = []
        r.forEach(c => {
          promesas.push(this.getCriterio(c.idCriterioXEncuesta))
        })
        return Promise.all(promesas)
      })
      .then(criterios => {
        const idEncuesta = Number(encuesta)
        let borrables = criterios.filter(c => c.idEncuesta === idEncuesta)
        return borrables
      })
      .then(criterios => {
        const aBorrar = votosViejos.filter(voto => {
          for (let i = 0; i < criterios.length; i++) {
            if (criterios[i].idCriteriosXEncuesta === voto.idCriterioXEncuesta) return true
          }
        })
        let promesas = []
        aBorrar.forEach(c => {
          promesas.push(axios.delete(URL + 'votosxcriterio/' + c.idVotosXCriterio))
        })
        return Promise.all(promesas)
      })
      .then(borrados => {
        const noBorrados = borrados.filter(b => b.data !== 1)
        if (noBorrados.length > 0) return false
        return borrados
      })
      .catch(err => {
        if (err.message === 'cool') {
          return true
        } else {
          console.log(err)
          return false
        }
      })
  },
  guardarCriteriosDefinitivos (criterios) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    const body = criterios.map(c => {
      return {esDefinitivo: true}
    })
    return axios.put(URL + 'criteriosxencuesta/' + criterios.toString(), body)
      .then(r => {
        return r.data.length > 0
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  guardarEncuesta (criterio, voto) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    const semana = this.getWeekNumber(new Date())
    const userId = Number(this.checkLogin())
    const body = {
      idCriterioXEncuesta: criterio,
      idUsuario: userId,
      fecha: new Date(),
      respuesta: voto,
      semana: semana
    }
    return this.getRespuestasXSemana(criterio, semana)
      .then(r => {
        if (r && r.length > 0) {
          return r.filter(v => v.idUsuario === userId)[0]
        } else {
          return null
        }
      })
      .then(r => {
        if (r) {
          return axios.put(URL + 'respuestasxcriterio/' + r.idRespuestasXCriterio, body)
        } else {
          return axios.post(URL + 'respuestasxcriterio/', body)
        }
      })
      .then(r => {
        return r.data
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  getRespuestasXSemana (criterio, semana) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    return axios.get(URL + 'respuestasxcriterio' +
      '?filter[]=idCriterioXEncuesta,eq,' +
      criterio +
      '&filter[]=semana,eq,' +
      semana +
      '&satisfy=all&transform=1')
      .then(r => {
        if (r.data.respuestasxcriterio.length > 0) {
          return r.data.respuestasxcriterio
        } else {
          return null
        }
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  getRespuestasHistoricas (criterio) {
    if (!this.checkLogin()) return Promise.reject(new Error('Not logged in'))
    return axios.get(URL + 'respuestasxcriterio' +
      '?filter[]=idCriterioXEncuesta,eq,' +
      criterio +
      '&satisfy=all&transform=1')
      .then(r => {
        if (r.data.respuestasxcriterio.length > 0) {
          return r.data.respuestasxcriterio
        } else {
          return null
        }
      })
      .catch(function (error) {
        console.log(error)
        return false
      })
  },
  getWeekNumber (d) {
    // Copy date so don't modify original
    d = new Date(Date.UTC(d.getFullYear(), d.getMonth(), d.getDate()))
    // Set to nearest Thursday: current date + 4 - current day number
    // Make Sunday's day number 7
    d.setUTCDate(d.getUTCDate() + 4 - (d.getUTCDay() || 7))
    // Get first day of year
    const yearStart = new Date(Date.UTC(d.getUTCFullYear(), 0, 1))
    // Calculate full weeks to nearest Thursday
    const weekNo = Math.ceil((((d - yearStart) / 86400000) + 1) / 7)
    // Return array of year and week number
    // return [d.getUTCFullYear(), weekNo]
    return weekNo
  }
}
