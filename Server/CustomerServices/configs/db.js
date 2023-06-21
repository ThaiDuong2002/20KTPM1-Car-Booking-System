import dotenv from 'dotenv';
import db from 'mongoose';
dotenv.config();
// Use connect method to connect to the Server
db.connect(process.env.MONGODB, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
  .then(() => {
    console.log('Kết nối cơ sở dữ liệu thành công');
    // Tiếp tục thực hiện các thao tác với cơ sở dữ liệu ở đây
  })
  .catch((error) => {
    console.error('Lỗi khi kết nối cơ sở dữ liệu:', error);
  });

export default db;

// diTnKgPVwyuCb6tt
