import CustormerRoute from './customer.route.js';

export default (app) => {
  app.use('/', CustormerRoute);
};
