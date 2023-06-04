export default {
  multipleMongooseToOject: function (DBarray) {
    return DBarray.map((e) => e.toObject());
  },
  mongooseToOject: function (DBarray) {
    return DBarray ? DBarray.toObject() : DBarray;
  },
};
