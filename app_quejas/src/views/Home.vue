<template>
  <!-- Contenido principal -->
  <div class="text-center">
    <!-- Snackbar de notificaciones -->
    <v-snackbar
      v-model="snackbar"
      :timeout="timeout">

      {{ textoSnackbar }}

      <template
        v-slot:action="{ attrs }">
          <v-btn
            color="success"
            text
            v-bind="attrs"
            @click="snackbar = false">
              Close
          </v-btn>
      </template>
    </v-snackbar>
    <!-- Termina snackbar de notificaciones -->
        <!-- Dialog de registro de producto -->
          <v-dialog
          v-model="dialog"
            max-width="500px">
            <v-card>
              <v-card-title>
                <span
                  class="headline">
                    Ingresar una queja
                </span>
              </v-card-title>

              <v-card-text>
                <v-form>
                  <v-container>
                    <v-alert
                      type="error"
                      v-model="alertaErrores">
                        Los registros contienen los siguientes errores:
                        <li
                          v-for="value in listadoErrores"
                          v-bind:key=value.id>
                            {{ value }}
                        </li>
                    </v-alert>
                    <v-row
                      align="center"
                      justify="center">
                        <v-col
                          cols="12"
                          sm="6"
                          md="6">
                          <v-text-field
                            v-model="editedItem.NumeroFactura"
                            label="Número de factura"
                            :rules="[rules.required]"
                            required>
                          </v-text-field>
                        </v-col>
                      <v-col
                        cols="12"
                        sm="6"
                        md="6">
                          <v-text-field
                            v-model="editedItem.Fecha"
                            label="Fecha de la factura"
                            :rules="[rules.required]"
                            required>
                          </v-text-field>
                      </v-col>
                      <v-col
                        cols="12"
                        sm="6"
                        md="6">
                        <v-btn-toggle
                          v-model="toggle_exclusive"
                          group
                          multiple>
                            <v-select
                              :items="datosProveedores"
                              item-text='NombreProveedor'
                              item-value='idProveedor'
                              v-model="editedItem.idProveedor"
                              label="Proveedor"
                              :rules="[rules.required]"
                              required>
                            </v-select>
                            <v-btn
                              text
                              @click="dialogProveedor = !dialogProveedor">
                                <v-icon>
                                  mdi-plus
                                </v-icon>
                            </v-btn>
                        </v-btn-toggle>
                      </v-col>
                      <v-col
                        cols="12"
                        sm="6"
                        md="6">
                          <v-text-field
                            v-model="editedItem.Queja"
                            label="Queja"
                            :rules="[rules.required]"
                            required>
                          </v-text-field>
                      </v-col>
                      <v-col
                        cols="12"
                        sm="6"
                        md="6">
                          <v-text-field
                            v-model="editedItem.Sugerencia"
                            label="Sugerencia"
                            :rules="[rules.required]"
                            required>
                          </v-text-field>
                      </v-col>
                    </v-row>
                  </v-container>
                </v-form>
              </v-card-text>

              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn
                  color="error"
                  text
                  @click="cerrarDialogRegistro">
                    Cancelar
                </v-btn>
                <v-btn
                  color="primary"
                  text
                  @click="registrarQueja">
                    Guardar
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
          <!-- Termina dialog de registro de producto -->

          <!-- Dialog de registro de proveedor -->
          <v-dialog
            v-model="dialogProveedor"
            max-width="500px">
              <v-card>
                <v-card-title>
                  <span
                    class="headline">
                      Registro de nuevo proveedor
                  </span>
                </v-card-title>

                <v-card-text>

                  <v-alert
                      type="error"
                      v-model="alertaErroresProv">
                        Los registros contienen los siguientes errores:
                        <li
                          v-for="value in listadoErroresProv"
                          v-bind:key="value.id">
                            {{ value }}
                        </li>
                    </v-alert>

                  <v-form>
                    <v-container>
                      <v-row
                        align="center"
                        justify="center">
                        <v-col
                          cols="12"
                          sm="6"
                          md="6">
                          <v-text-field
                            v-model="nuevoProveedor.NombreProveedor"
                            label="Nombre"
                            :rules="[rules.required]"
                            required>
                          </v-text-field>
                        </v-col>
                        <v-col
                          cols="12"
                          sm="6"
                          md="6">
                            <v-text-field
                              v-model="nuevoProveedor.NumeroNIT"
                              label="Numero de NIT"
                              :rules="[rules.required]"
                              required>
                            </v-text-field>
                        </v-col>
                        <v-col
                          cols="12"
                          sm="6"
                          md="6">
                            <v-text-field
                              v-model="nuevoProveedor.Direccion"
                              label="Dirección"
                              :rules="[rules.required]"
                              required>
                            </v-text-field>
                        </v-col>
                        <v-btn-toggle
                          v-model="toggle_exclusive"
                          group
                          multiple>
                            <v-select
                              :items="datosMunicipios"
                              item-text='NombreMunicipio'
                              item-value='idMunicipio'
                              v-model="nuevoProveedor.MunicipioSede"
                              label="Sede"
                              :rules="[rules.required]"
                              required>
                            </v-select>
                        </v-btn-toggle>
                      </v-row>
                    </v-container>
                  </v-form>
                </v-card-text>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn
                    color="error"
                    text
                    @click="cerrarDialogProveedor">
                      Cancelar
                  </v-btn>
                  <v-btn
                    color="primary"
                    text
                    @click="guardarProveedor">
                      Guardar
                  </v-btn>
                </v-card-actions>
              </v-card>
          </v-dialog>
          <!-- Termina dialog de registro de proveedor -->

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
      dialog: true,
      dialogProveedor: false,
      alertaErrores: false,
      alertaErroresProv: false,
      rules: {
        required: value => !!value || 'Campo requerido.',
        min: v => v.length >= 8 || '8 caracteres como mínimo',
        counter: value => value.length <= 20 || 'Max 20 characters',
        email: value => {
          const pattern =
            /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
          return pattern.test(value) || 'Correo inválido'
        },
      },
      listadoErrores: [],
      listadoErroresProv: [],
      datosTabla: [],
      select: [],
      datosProveedores: [],
      datosMunicipios: [],
      editedIndex: -1,
      idProductoEditar: 0,
      editarCodigo: false,
      editedItem: {
        NumeroFactura: '',
        Fecha: '',
        idProveedor: '',
        Queja: '',
        Sugerencia: '',
      },
      defaultItem: {
        NumeroFactura: '',
        Fecha: '',
        idProveedor: '',
        Queja: '',
        Sugerencia: '',
      },
      nuevoProveedor: {
        NombreProveedor: '',
        NumeroNIT: '',
        Direccion: '',
        MunicipioSede: '',
      },
      defaultnuevoProveedor: {
        NombreProveedor: '',
        NumeroNIT: '',
        Direccion: '',
        MunicipioSede: '',
      },
    }),

    computed: {
      formTitle() {
        return this.editedIndex === -1 ? 'Nueva queja' : 'Editar queja'
      },
    },

    watch: {
      dialog(val) {
        val || this.cerrarDialogProveedor() || this.cerrarDialogRegistro()
      },
    },

    created() {
      this.initialize()
    },

    methods: {
      initialize() {
        // Proveedores
        axios
          .get("/api/proveedores")
          .then(response => {
            if (response.data.total != 0) {
              this.datosProveedores = response.data.detalle
            }
          })
          .catch(function (error) {
            console.log(error);
          })
        // Municipios
        axios
          .get("/api/municipios")
          .then(response => {
            if (response.data.total != 0) {
              this.datosMunicipios = response.data.detalle
            }
          })
          .catch(function (error) {
            console.log(error);
          })
      },

      registrarQueja() {
        // Guardamos la información
          axios
            .post("/api/quejas", this.editedItem)
            .then(response => {
              if (response.data.status == 200) {
                //console.log("exito")
                // Mostramos la confirmación
                this.textoSnackbar = 'Producto agregado exitosamente'
                this.snackbar = !this.snackbar
                this.cerrarDialogRegistro()
              } else if (response.data.status == 404) {
                //console.log("error")
                this.listadoErrores = response.data.errores
                this.alertaErrores = true
              }
            })
            .catch(function (error) {
              console.log(error);
            })
        this.initialize()
      },

      guardarProveedor() {
        axios
          .post("/api/proveedores",
            this.nuevoProveedor)
          .then(response => {
              if (response.data.status == 200) {
                //console.log("exito")
                // Mostramos la confirmación
                this.textoSnackbar = 'Proveedor agregada exitosamente'
                this.snackbar = !this.snackbar
                this.cerrarDialogProveedor()
              } else if (response.data.status == 404) {
                //console.log("error")
                this.listadoErroresProv = response.data.errores
                this.alertaErroresProv = true
                console.log(this.nuevoProveedor);
                console.log(response.data.status);
              }
            })
          .catch(function (error) {
            console.log(error);
          })
        this.initialize()
      },

      cerrarDialogProveedor() {
        this.alertaErrores = false
        this.alertaErroresProv = false
        this.dialogProveedor = false
        //this.dialog = false
        this.$nextTick(() => {
          this.nuevoProveedor = Object.assign({}, this.defaultnuevoProveedor)
        })
      },

      cerrarDialogRegistro() {
        this.alertaErrores = false
        this.alertaErroresProv = false
        this.dialogProveedor = false
        this.editarCodigo = false
        this.dialog = false
        this.$nextTick(() => {
          this.editedItem = Object.assign({}, this.defaultItem)
          this.editedIndex = -1
          this.idProductoEditar = 0
        })
      },
    },
  }
</script>