<template>
  <div>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
      <div class="container">
        <a class="navbar-brand" href="/">
          <i class="bi bi-book"></i> Mi Blog
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav ms-auto">
            <li class="nav-item">
              <a class="nav-link" href="/">Inicio</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/admin">Administración</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- Hero Section -->
    <div class="bg-primary text-white py-5">
      <div class="container text-center">
        <h1 class="display-4">Bienvenido a Mi Blog</h1>
        <p class="lead">Descubre historias increíbles de nuestros autores</p>
      </div>
    </div>

    <!-- Posts Section -->
    <div class="container my-5">
      <div v-if="loading" class="text-center">
        <div class="spinner-border text-primary" role="status">
          <span class="visually-hidden">Cargando...</span>
        </div>
      </div>

      <div v-else>
        <div class="row" v-if="posts.length > 0">
          <div class="col-md-4 mb-4" v-for="post in posts" :key="post.id">
            <div class="card h-100">
              <img :src="'/' + post.imagen" :alt="post.titulo" class="card-img-top post-image">
              <div class="card-body d-flex flex-column">
                <h5 class="card-title">{{ post.titulo }}</h5>
                <p class="card-text post-content flex-grow-1">{{ post.contenido }}</p>
                <div class="mt-auto">
                  <p class="card-text">
                    <small class="text-muted">
                      Por {{ post.autor.nombre }} {{ post.autor.apellidos }}
                    </small>
                  </p>
                  <button class="btn btn-primary" @click="viewPost(post)">
                    Leer más <i class="bi bi-arrow-right"></i>
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div v-else class="text-center py-5">
          <i class="bi bi-journal-x display-1 text-muted"></i>
          <h3 class="mt-3">No hay posts disponibles</h3>
          <p class="text-muted">¡Sé el primero en crear un post!</p>
        </div>
      </div>
    </div>

    <!-- Post Detail Modal -->
    <div class="modal fade" id="postModal" tabindex="-1">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">{{ selectedPost?.titulo }}</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <img v-if="selectedPost?.imagen" :src="'/' + selectedPost.imagen" :alt="selectedPost.titulo" class="img-fluid mb-3">
            <p>{{ selectedPost?.contenido }}</p>
            <hr>
            <p><strong>Autor:</strong> {{ selectedPost?.autor?.nombre }} {{ selectedPost?.autor?.apellidos }}</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'BlogPublic',
  data() {
    return {
      posts: [],
      selectedPost: null,
      loading: true
    }
  },
  mounted() {
    this.fetchPosts();
  },
  methods: {
    async fetchPosts() {
      try {
        this.loading = true;
        const response = await axios.get('/api/posts');
        this.posts = response.data;
      } catch (error) {
        console.error('Error fetching posts:', error);
      } finally {
        this.loading = false;
      }
    },
    viewPost(post) {
      this.selectedPost = post;
      this.$nextTick(() => {
        const modalElement = document.getElementById('postModal');
        if (modalElement) {
          const modal = new window.bootstrap.Modal(modalElement);
          modal.show();
        }
      });
    }
  }
}
</script>
