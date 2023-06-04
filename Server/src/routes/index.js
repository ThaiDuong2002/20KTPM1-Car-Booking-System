import homeRouter from './home.js';

const route = (app) => {
  app.use('/', homeRouter);
}

export default route;
