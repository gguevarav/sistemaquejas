<template>
  <div>
    <v-app-bar
        color="secondary"
        dense
        dark
        app>
      <v-app-bar-nav-icon
          @click="ocultarBarra()">
        <v-icon>
          {{ iconoBarra }}
        </v-icon>
      </v-app-bar-nav-icon>
      <v-toolbar-title>Sistema de reportes de Quejas DIACO</v-toolbar-title>
    </v-app-bar>
    <v-navigation-drawer
        color="primary"
        v-model="barraNavegacion"
        app
        floating
        :permanent="barraNavegacion"
        :mini-variant.sync="mini"
        dark>
      <v-list>
        <v-list-item class="px-2">
          <v-list-item-avatar>
            <v-img src="@/assets/images/nouser.png"></v-img>
          </v-list-item-avatar>
        </v-list-item>
        <v-list-item>
          <v-list-item-content>
            <v-list-item-title class="title">admin</v-list-item-title>
            <v-list-item-subtitle>admin@admin.com</v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>
      </v-list>
      <v-divider></v-divider>
      <v-list
          nav
          dense
      >
        <v-list-item
            :to="{name: item.nombre}"
            link
            v-for="(item, index) in rutasMostrar"
            v-bind:key="index">
          <v-list-item-icon>
            <v-icon>{{ item.icono }}</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title> {{ item.nombreMostrar }} </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
  </div>
</template>

<script>

export default {
  data () {
    return {
      barraNavegacion: true,
      iconoBarra: 'mdi-minus',
      rutasMostrar: [
          {
            nombre: 'home',
            icono: 'mdi-home',
            nombreMostrar: 'Inicio',
          },
          {
            nombre: 'proveedores',
            icono: 'mdi-account',
            nombreMostrar: 'Proveedores',
          },
          {
            nombre: 'quejas',
            icono: 'mdi-package-variant',
            nombreMostrar: 'Quejas',
          },
          {
            nombre: 'reportes',
            icono: 'mdi-clipboard',
            nombreMostrar: 'Reportes',
          },
          {
            nombre: 'about',
            icono: 'mdi-help',
            nombreMostrar: 'Acerca de',
          },
          ],
    }
  },
  created () {

  },
  methods: {
    ocultarBarra() {
      if (this.barraNavegacion == true) {
        this.barraNavegacion = false;
        this.iconoBarra = 'mdi-plus'
      } else if (this.barraNavegacion == false) {
        this.barraNavegacion = true;
        this.iconoBarra = 'mdi-minus'
      }
    },
  },
  computed: {
    mini: {
      get() {
        return this.$vuetify.breakpoint.mdAndDown || this.overwriteBreakpoint;
      },
      set(value) {
        this.overwriteBreakpoint = value;
      }
    },
  },
}
</script>
