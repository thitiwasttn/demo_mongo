use bookstore;
show dbs;

db.bookstore.insertOne({"name": "Thitiwas Nupan", "phone" : "0942518661"});

db.bookstore.find();

show collection;

db.bookstore.insertOne({"name": "Thitiwas Nupan2", "phone" : "0942518662", "email": ["thitiwas.nn@gmail.com", "twopee26@gmail.com"]});

db.bookstore.find({name: "Thitiwas Nupan"});

db.bookstore.findOne({name: "Thitiwas Nupan"});

db.bookstore.findOne({name: "Thitiwas Nupan"}).name;


//find all
db.bookstore.find({});

db.package.insertMany([
{
item: "0", size: {w: 150, l: 16}
},
{
item: "0A", size: {w: 200, l: 17}
},
]);

db.package.insertOne({
item: "0B", size: {w: 150, l: 20}
})

db.package.find({});

//หา size.w = 150
db.package.find({"size.w" : 150});

// less then 200
db.package.find({"size.w" : {$lt: 200}})

//SELECT *
  //FROM db.package
  //WHERE item = '0'
  //AND size.w < 200;
db.package.find({$and: [{"item": {$eq: "0"}}], "size.w" : {$lt: 200}});

db.customer.insertMany([
{
"name": "thitiwas", email: ["thitiwas@gmail.com"]
},
{
"name": "thitiwas2", email: ["thitiwas.n@gmail.com"]
},
{
"name": "thitiwas3", email: ["thitiwas.n@gmail.com"]
}]);

db.customer.insertOne({
"name": "thitiwas", email: ["thitiwas.n@g-able.com"]
});

db.customer.insertOne({
"name": "thitiwas", email: ["thitiwas.n@g-able.com"], is_delete: false
});

db.customer.find({});

db.customer.find({email: "thitiwas.n@gmail.com"});

db.customer.find({$or: [{is_delete: false}, {is_delete: null}]});

db.customer.find({$and: [{is_delete: true}]})

// name in (?,?)
db.customer.find({name: {$in: ["thitiwas2", "thitiwas3"]}});

db.customer.find({$and: [{name: {$in: ["thitiwas2", "thitiwas3"]}}, {email: {$regex: /@gmail\.com/}}]});

db.customer.find({$and: [{email: {$regex: /@gmail\.com/}}]});

db.customer.updateMany({is_delete: null}, {$set: {is_delete: false}});

db.customer.updateOne({name: "thitiwasz"}, {$set: {is_delete: true}});

db.t_phone.insertMany(
[{
name: 'thitiwas', phone: "0942518661"
},{
name: 'thitiwas2', phone: "0942518662"
},{
name: 'thitiwas3', phone: ["0942518663", "0942518664"]
},{
name: 'thitiwas4', phone: ["0942518665", "0942518666"]
}
]
);

db.t_phone.find({});

//find type array
db.t_phone.find({$and: [{phone: {$type: "array"}}]});
db.t_phone.find({$and: [{phone: {$type: "array"}}]});
db.t_phone.find({$and: [{phone: {$regex: /094251/}}, {phone: {$type: "array"}}]});
//db.t_phone.find({$and: [{phone: {$type: "array"}}, {phone: {$gte: 2}}]});
//db.t_phone.find({$and: [{phone: {$gte: 2}}]})


db.t_phone.updateOne({_id: ObjectId("657712d5c9246e4d6522ec85")}, {$set: {name: "thitiwas nupan"}});
db.t_phone.findOne({_id: ObjectId("657712d5c9246e4d6522ec85")});
db.t_phone.find({})
db.t_phone.find({name: {$regex: /thitiwas[0-9]/}})

db.t_phone.updateMany({}, {$set: {status: true}});

db.t_phone.updateMany({name: {$regex: /thitiwas[0-9]/}}, {$set: {status: false}})

db.t_phone.deleteOne({_id: ObjectId("657712d5c9246e4d6522ec85")})



db.m_user.find({});
db.m_user.deleteMany({status: true});
db.m_user.insertOne({name: "Thitiwas Nupan", email: "thitiwas.nn@gmail.com", t_phone: "0942518661", status: true});
db.m_user.insertOne({name: "Chalopakron Timkul", email: "chalo@gmail.com", t_phone: "0868108661", status: true});
db.m_user.updateOne({_id: ObjectId("65881776faec8d4c43bb0272")}, {$set: {social: {facebook: "thitiwas.nu"}}})
db.m_user.updateOne({_id: ObjectId("65881777faec8d4c43bb0273")}, {$set: {social: {facebook: "chalo.t"}}})
db.m_user.findOne({_id: ObjectId("65881776faec8d4c43bb0272")})
db.m_user.find({social:{facebook:"thitiwas.nu"}})

db.m_platform.find({});
db.m_platform.insertMany([{name: "PC", _id: "PC"}, {name: "iOS", _id: "IOS"}, {name: "Android", _id: "AND"}])

db.m_game.find({});
db.m_game.insertMany([{name: "cs2", _id: "CS2"}, {name: "Team Fight Tactict", _id: "TFT"}]);
db.m_game.updateOne({_id: "CS2"}, {$set: {platform: ["PC"]}})
db.m_game.updateOne({_id: "TFT"}, {$set: {platform: ["IOS", "AND", "PC"]}})

db.m_user.updateOne({email: "thitiwas.nn@gmail.com"}, {$set: {gamePlay: ["CS2", "TFT"]}})
//db.m_user.updateMany({}, {$unset: {gamePlay: ""}})
db.m_user.findOne({email: "thitiwas.nn@gmail.com"}).gamePlay._id;

lookupStage = {
  $lookup : {
    from: 'm_game',
    localField: 'gamePlay',
    foreignField: '_id',
    as: 'gameList'
  }
};
where1 = {$match: {email: "thitiwas.nn@gmail.com"}};
where2 = {$match: {email: {$in: ["thitiwas.nn@gmail.com", "chalo@gmail.com"]}}};
unwind = {$unwind: "$gameList"};
unwindGamePlay = {$unwind: "$gamePlay"};
db.m_user.aggregate([where1, lookupStage]);
db.m_user.aggregate([where2, lookupStage, unwind]);

db.m_user.aggregate([where2, unwindGamePlay]);

db.m_user.aggregate([{$match: {email: "thitiwas.nn@gmail.com"}}, {
$lookup : {
    from: 'm_game',
    localField: 'gamePlay._id',
    foreignField: '_id',
    as: 'gameList'
  }
}]);

db.getCollection('m_user').aggregate(
  [
    {
      $lookup: {
        from: 'm_game',
        localField: 'gamePlay',
        foreignField: '_id',
        as: 'gameList'
      }
    },
    {
      $match: {
        email: {
          $in: [
            'thitiwas.nn@gmail.com',
            'chalo@gmail.com'
          ]
        }
      }
    }
  ],
  { maxTimeMS: 60000, allowDiskUse: true }
);


db.m_user.find({}).count();

// create index
db.m_user.createIndex({email: 1})
db.m_user.getIndexes();
/*
[
  {
    "key": {
      "_id": 1
    },
    "name": "_id_",
    "v": 2
  },
  {
    "key": {
      "email": 1
    },
    "name": "email_1",
    "v": 2
  }
]
*/
db.m_user.find({email: 'thitiwas.nn@gmail.com'});


db.m_store.deleteMany({})
db.m_store.insertMany([{
name: 'P1',
_id: 'P1',
owner: 'thitiwas.nn@gmail.com',
location: {
type: "Point",
coordinates: [100.4732416, 13.860864]
}
},

{
name: 'Central Rama2',
_id: 'CR2',
owner: 'thitiwas.nn@gmail.com',
location: {
type: "Point",
coordinates: [100.4351476,13.6639306]
}
}]);

db.m_store.createIndex({location: "2dsphere"})

db.m_store.find({
location: {
$near: {$geometry: {type: "Point", coordinates: [100.41039579996999, 13.637385160016768 ]}, $minDistance: 0,$maxDistance: 10000}
}});
