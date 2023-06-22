import TestRoute from './test.route.js';

export default (app) => {
  app.use('/test', TestRoute);
};
