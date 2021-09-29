<template>
  <!-- Contenido principal -->
  <div class="text-center">

    <!-- Tabla de productos -->
    <v-data-table
      dense
      :headers="headers"
      :items="datosTabla"
      :items-per-page="10"
      sort-by="NombreProducto"
      class="elevation-1">
      <template
        v-slot:top>
        <v-toolbar
          flat
          color="white">
          <v-toolbar-title>
            Listado de quejas
          </v-toolbar-title>
          <v-spacer></v-spacer>
          <!-- Dialog de botones de agregar y recargar -->
          <v-dialog>
            <template
                v-slot:activator="{  }">
                <v-btn
                  text
                  class="mb-2"
                  @click="initialize">
                    <v-icon>
                      mdi-reload
                    </v-icon>
                </v-btn>
              </template>
          </v-dialog>
          <!-- Termina dialog de botones de agregar y recargar -->
        </v-toolbar>
      </template>
    </v-data-table>
    <!-- Termina la tabla de productos -->
  </div>
</template>

<script>
  import axios from "axios";

  export default {
    data: () => ({
      snackbar: false,
      textoSnackbar: '',
      timeout: 3000,
      toggle_exclusive: undefined,
      dialog: false,
      dialogUnidadMedida: false,
      alertaErrores: false,
      alertaErroresUM: false,
      headers: [{
          text: 'idQueja',
          align: 'start',
          sortable: false,
          value: 'idQueja',
        },
        {
          text: 'Numero Factura',
          value: 'Numero Factura'
        },
        {
          text: 'Fecha',
          value: 'Fecha'
        },
        {
          text: 'Queja',
          value: 'Queja'
        },
        {
          text: 'Sugerencia',
          value: 'Sugerencia'
        },
        {
          text: 'Nombre proveedor',
          value: 'NombreProveedor'
        },
      ],
      datosTabla: []
    }),

    computed: {
      
    },

    watch: {
      
    },

    created() {
      this.initialize()
    },

    methods: {
      initialize() {
        axios
          .get("/api/quejas")
          .then(response => {
            if (response.data.total != 0) {
              this.datosTabla = response.data.detalle
            }
          })
          .catch(function (error) {
            console.log(error);
          })
      },
    },
  }
</script>