import axios from 'axios';

const baseURL = (import.meta.env.VITE_API_BASE_URL || '').trim();

const client = axios.create({
  baseURL,
  timeout: 10000
});

client.interceptors.response.use(
  (response) => response,
  (error) => {
    const message =
      error.response?.data?.message ||
      error.message ||
      '请求失败，请检查后端服务是否可用。';
    return Promise.reject(new Error(message));
  }
);

export default client;
