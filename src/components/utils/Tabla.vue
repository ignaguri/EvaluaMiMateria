<template>
  <div>
    <div class="header">
      <slot name="header">
        <h4 class="title">{{title}}</h4>
        <p class="category">{{subTitle}}</p>
      </slot>
    </div>
    <div class="content table-responsive table-full-width">
      <table class="table" :class="tableClass">
        <thead>
          <th v-for="column in columns" :key="column.id">{{column}}</th>
        </thead>
        <tbody>
          <tr v-for="item in data" :key="item.id" @click="selected">
            <td v-for="column in columns" v-if="hasValue(item, column)" :key="column.id">{{itemValue(item, column)}} </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>
<script>
export default {
  props: {
    columns: Array,
    data: Array,
    type: {
      type: String, // table table-bordered || table table-hover || table table-striped
      default: 'table table-bordered table-hover table-striped'
    },
    title: {
      type: String,
      default: ''
    },
    subTitle: {
      type: String,
      default: ''

    }
  },
  computed: {
    tableClass () {
      return `table-${this.type}`
    }
  },
  methods: {
    hasValue (item, column) {
      // return item[column.toLowerCase()] !== 'undefined'
      return item[column.toLowerCase().replace(/\s/g, '')] !== 'undefined'
    },
    itemValue (item, column) {
      // return item[column.toLowerCase()]
      return item[column.toLowerCase().replace(/\s/g, '')]
    },
    selected (e) {
      this.$emit('selected', e.target.parentElement.children[0].innerHTML)
    }
  }
}

</script>
<style>

</style>
