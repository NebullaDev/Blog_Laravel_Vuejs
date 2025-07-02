<template>
  <div>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
      <div class="container">
        <a class="navbar-brand" href="/admin">
          <i class="bi bi-gear"></i> Administración del Blog
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav ms-auto">
            <li class="nav-item">
              <a class="nav-link" href="/">Ver Blog</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- Admin Panel -->
    <div class="container-fluid mt-4">
      <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3">
          <div class="card">
            <div class="card-header">
              <h5><i class="bi bi-list"></i> Menú</h5>
            </div>
            <div class="list-group list-group-flush">
              <button 
                class="list-group-item list-group-item-action" 
                :class="{ active: activeTab === 'autores' }"
                @click="activeTab = 'autores'"
              >
                <i class="bi bi-people"></i> Autores
              </button>
              <button 
                class="list-group-item list-group-item-action" 
                :class="{ active: activeTab === 'posts' }"
                @click="activeTab = 'posts'"
              >
                <i class="bi bi-journal-text"></i> Posts
              </button>
            </div>
          </div>
        </div>

        <!-- Main Content -->
        <div class="col-md-9">
          <!-- Autores Management -->
          <div v-if="activeTab === 'autores'">
            <div class="d-flex justify-content-between align-items-center mb-4">
              <h2><i class="bi bi-people"></i> Gestión de Autores</h2>
              <button class="btn btn-primary" @click="showAutorForm()" :disabled="loading">
                <span v-if="loading" class="spinner-border spinner-border-sm me-2" role="status"></span>
                <i class="bi bi-plus"></i> Nuevo Autor
              </button>
            </div>

            <div class="card">
              <div class="card-body">
                <div v-if="autores.length === 0" class="text-center py-4">
                  <i class="bi bi-person-x display-1 text-muted"></i>
                  <h4 class="mt-3">No hay autores registrados</h4>
                  <p class="text-muted">Comienza agregando tu primer autor</p>
                </div>
                <div v-else class="table-responsive">
                  <table class="table table-striped">
                    <thead>
                      <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Apellidos</th>
                        <th>Posts</th>
                        <th>Acciones</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="autor in autores" :key="autor.id">
                        <td>{{ autor.id }}</td>
                        <td>{{ autor.nombre }}</td>
                        <td>{{ autor.apellidos }}</td>
                        <td>{{ autor.posts ? autor.posts.length : 0 }}</td>
                        <td>
                          <button class="btn btn-sm btn-outline-primary me-2" @click="editAutor(autor)">
                            <i class="bi bi-pencil"></i>
                          </button>
                          <button class="btn btn-sm btn-outline-danger" @click="deleteAutor(autor.id)">
                            <i class="bi bi-trash"></i>
                          </button>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>

          <!-- Posts Management -->
          <div v-if="activeTab === 'posts'">
            <div class="d-flex justify-content-between align-items-center mb-4">
              <h2><i class="bi bi-journal-text"></i> Gestión de Posts</h2>
              <button class="btn btn-primary" @click="showPostForm()" :disabled="autores.length === 0 || loading">
                <span v-if="loading" class="spinner-border spinner-border-sm me-2" role="status"></span>
                <i class="bi bi-plus"></i> Nuevo Post
              </button>
            </div>

            <div v-if="autores.length === 0" class="alert alert-warning">
              <i class="bi bi-exclamation-triangle"></i>
              Necesitas crear al menos un autor antes de poder crear posts.
            </div>

            <div class="card">
              <div class="card-body">
                <div v-if="posts.length === 0" class="text-center py-4">
                  <i class="bi bi-journal-x display-1 text-muted"></i>
                  <h4 class="mt-3">No hay posts registrados</h4>
                  <p class="text-muted">Comienza agregando tu primer post</p>
                </div>
                <div v-else class="table-responsive">
                  <table class="table table-striped">
                    <thead>
                      <tr>
                        <th>ID</th>
                        <th>Título</th>
                        <th>Autor</th>
                        <th>Imagen</th>
                        <th>Acciones</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="post in posts" :key="post.id">
                        <td>{{ post.id }}</td>
                        <td>{{ post.titulo }}</td>
                        <td>{{ post.autor?.nombre }} {{ post.autor?.apellidos }}</td>
                        <td>
                          <img :src="'/' + post.imagen" :alt="post.titulo" class="img-thumbnail" style="width: 50px; height: 50px; object-fit: cover;">
                        </td>
                        <td>
                          <button class="btn btn-sm btn-outline-primary me-2" @click="editPost(post)">
                            <i class="bi bi-pencil"></i>
                          </button>
                          <button class="btn btn-sm btn-outline-danger" @click="deletePost(post.id)">
                            <i class="bi bi-trash"></i>
                          </button>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Autor Modal -->
    <div class="modal fade" id="autorModal" tabindex="-1">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">{{ autorForm.id ? 'Editar' : 'Nuevo' }} Autor</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <form @submit.prevent="saveAutor">
              <div class="mb-3">
                <label class="form-label">Nombre</label>
                <input type="text" class="form-control" v-model="autorForm.nombre" required>
              </div>
              <div class="mb-3">
                <label class="form-label">Apellidos</label>
                <input type="text" class="form-control" v-model="autorForm.apellidos" required>
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" :disabled="loading">Cancelar</button>
            <button type="button" class="btn btn-primary" @click="saveAutor" :disabled="loading">
              <span v-if="loading" class="spinner-border spinner-border-sm me-2" role="status"></span>
              Guardar
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Post Modal -->
    <div class="modal fade" id="postModal" tabindex="-1">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">{{ postForm.id ? 'Editar' : 'Nuevo' }} Post</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <form @submit.prevent="savePost">
              <div class="mb-3">
                <label class="form-label">Título</label>
                <input type="text" class="form-control" v-model="postForm.titulo" required>
              </div>
              <div class="mb-3">
                <label class="form-label">Contenido</label>
                <textarea class="form-control" rows="5" v-model="postForm.contenido" required></textarea>
              </div>
              <div class="mb-3">
                <label class="form-label">Autor</label>
                <select class="form-select" v-model="postForm.autor_id" required>
                  <option value="">Selecciona un autor</option>
                  <option v-for="autor in autores" :key="autor.id" :value="autor.id">
                    {{ autor.nombre }} {{ autor.apellidos }}
                  </option>
                </select>
              </div>
              <div class="mb-3">
                <label class="form-label">Imagen</label>
                <input type="file" class="form-control" @change="handleImageUpload" accept="image/*" :required="!postForm.id">
                <div v-if="postForm.imagen && typeof postForm.imagen === 'string'" class="mt-2">
                  <img :src="'/' + postForm.imagen" class="img-thumbnail" style="max-width: 200px;">
                </div>
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" :disabled="loading">Cancelar</button>
            <button type="button" class="btn btn-primary" @click="savePost" :disabled="loading">
              <span v-if="loading" class="spinner-border spinner-border-sm me-2" role="status"></span>
              Guardar
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'BlogAdmin',
  data() {
    return {
      activeTab: 'autores',
      autores: [],
      posts: [],
      autorForm: {
        id: null,
        nombre: '',
        apellidos: ''
      },
      postForm: {
        id: null,
        titulo: '',
        contenido: '',
        autor_id: '',
        imagen: null
      },
      loading: false
    }
  },
  mounted() {
    this.fetchAutores();
    this.fetchPosts();
  },
  methods: {
    async fetchAutores() {
      try {
        this.loading = true;
        const response = await axios.get('/api/autores');
        this.autores = response.data;
      } catch (error) {
        console.error('Error fetching autores:', error);
        alert('Error al cargar autores');
      } finally {
        this.loading = false;
      }
    },
    async fetchPosts() {
      try {
        this.loading = true;
        const response = await axios.get('/api/posts');
        this.posts = response.data;
      } catch (error) {
        console.error('Error fetching posts:', error);
        alert('Error al cargar posts');
      } finally {
        this.loading = false;
      }
    },
    showAutorForm(autor = null) {
      if (autor) {
        this.autorForm = { ...autor };
      } else {
        this.autorForm = { id: null, nombre: '', apellidos: '' };
      }
      
      // Usar setTimeout para asegurar que el DOM esté listo
      this.$nextTick(() => {
        const modalElement = document.getElementById('autorModal');
        if (modalElement) {
          const modal = new window.bootstrap.Modal(modalElement);
          modal.show();
        }
      });
    },
    async saveAutor() {
      if (!this.autorForm.nombre || !this.autorForm.apellidos) {
        alert('Por favor completa todos los campos');
        return;
      }

      try {
        this.loading = true;
        if (this.autorForm.id) {
          await axios.put(`/api/autores/${this.autorForm.id}`, {
            nombre: this.autorForm.nombre,
            apellidos: this.autorForm.apellidos
          });
        } else {
          await axios.post('/api/autores', {
            nombre: this.autorForm.nombre,
            apellidos: this.autorForm.apellidos
          });
        }
        
        await this.fetchAutores();
        
        // Cerrar modal
        const modalElement = document.getElementById('autorModal');
        if (modalElement) {
          const modal = window.bootstrap.Modal.getInstance(modalElement);
          if (modal) {
            modal.hide();
          }
        }
        
        alert(this.autorForm.id ? 'Autor actualizado correctamente' : 'Autor creado correctamente');
      } catch (error) {
        console.error('Error saving autor:', error);
        alert('Error al guardar autor');
      } finally {
        this.loading = false;
      }
    },
    editAutor(autor) {
      this.showAutorForm(autor);
    },
    async deleteAutor(id) {
      if (confirm('¿Estás seguro de eliminar este autor? También se eliminarán todos sus posts.')) {
        try {
          this.loading = true;
          await axios.delete(`/api/autores/${id}`);
          await this.fetchAutores();
          await this.fetchPosts();
          alert('Autor eliminado correctamente');
        } catch (error) {
          console.error('Error deleting autor:', error);
          alert('Error al eliminar autor');
        } finally {
          this.loading = false;
        }
      }
    },
    showPostForm(post = null) {
      if (post) {
        this.postForm = { ...post };
      } else {
        this.postForm = { id: null, titulo: '', contenido: '', autor_id: '', imagen: null };
      }
      
      this.$nextTick(() => {
        const modalElement = document.getElementById('postModal');
        if (modalElement) {
          const modal = new window.bootstrap.Modal(modalElement);
          modal.show();
        }
      });
    },
    handleImageUpload(event) {
      const file = event.target.files[0];
      if (file) {
        // Validar tipo de archivo
        const allowedTypes = ['image/jpeg', 'image/png', 'image/jpg', 'image/gif'];
        if (!allowedTypes.includes(file.type)) {
          alert('Por favor selecciona un archivo de imagen válido (JPEG, PNG, JPG, GIF)');
          event.target.value = '';
          return;
        }
        
        // Validar tamaño (2MB max)
        if (file.size > 2 * 1024 * 1024) {
          alert('El archivo es demasiado grande. Máximo 2MB permitido.');
          event.target.value = '';
          return;
        }
        
        this.postForm.imagen = file;
      }
    },
    async savePost() {
      if (!this.postForm.titulo || !this.postForm.contenido || !this.postForm.autor_id) {
        alert('Por favor completa todos los campos obligatorios');
        return;
      }

      if (!this.postForm.id && !this.postForm.imagen) {
        alert('Por favor selecciona una imagen para el post');
        return;
      }

      try {
        this.loading = true;
        const formData = new FormData();
        formData.append('titulo', this.postForm.titulo);
        formData.append('contenido', this.postForm.contenido);
        formData.append('autor_id', this.postForm.autor_id);
        
        if (this.postForm.imagen && typeof this.postForm.imagen !== 'string') {
          formData.append('imagen', this.postForm.imagen);
        }

        if (this.postForm.id) {
          formData.append('_method', 'PUT');
          await axios.post(`/api/posts/${this.postForm.id}`, formData, {
            headers: { 'Content-Type': 'multipart/form-data' }
          });
        } else {
          await axios.post('/api/posts', formData, {
            headers: { 'Content-Type': 'multipart/form-data' }
          });
        }
        
        await this.fetchPosts();
        
        // Cerrar modal
        const modalElement = document.getElementById('postModal');
        if (modalElement) {
          const modal = window.bootstrap.Modal.getInstance(modalElement);
          if (modal) {
            modal.hide();
          }
        }
        
        alert(this.postForm.id ? 'Post actualizado correctamente' : 'Post creado correctamente');
      } catch (error) {
        console.error('Error saving post:', error);
        if (error.response && error.response.data && error.response.data.errors) {
          const errors = Object.values(error.response.data.errors).flat();
          alert('Errores de validación:\n' + errors.join('\n'));
        } else {
          alert('Error al guardar post');
        }
      } finally {
        this.loading = false;
      }
    },
    editPost(post) {
      this.showPostForm(post);
    },
    async deletePost(id) {
      if (confirm('¿Estás seguro de eliminar este post?')) {
        try {
          this.loading = true;
          await axios.delete(`/api/posts/${id}`);
          await this.fetchPosts();
          alert('Post eliminado correctamente');
        } catch (error) {
          console.error('Error deleting post:', error);
          alert('Error al eliminar post');
        } finally {
          this.loading = false;
        }
      }
    }
  }
}
</script>
