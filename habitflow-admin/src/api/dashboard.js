import client from './client.js';

const withParams = (endpoint, userId) =>
  client.get(endpoint, { params: { userId } }).then((res) => res.data);

export const fetchTodayDashboard = (userId) =>
  withParams('/v1/dashboard/today', userId);

export const fetchCoachDashboard = (userId) =>
  withParams('/v1/dashboard/coach', userId);

export const fetchLogDashboard = (userId) => withParams('/v1/dashboard/log', userId);

export const fetchWeeklyDashboard = (userId) =>
  withParams('/v1/dashboard/weekly', userId);

export const fetchProfileDashboard = (userId) => withParams('/v1/profile', userId);
