import './bootstrap';
import { createApp } from 'vue';

// Import Bootstrap JS and make it available globally
import * as bootstrap from 'bootstrap';
window.bootstrap = bootstrap;

// Import components
import BlogPublic from './components/BlogPublic.vue';
import BlogAdmin from './components/BlogAdmin.vue';

const app = createApp({});

app.component('blog-public', BlogPublic);
app.component('blog-admin', BlogAdmin);

app.mount('#app');
