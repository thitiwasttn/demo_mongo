
use admin;
db.createUser({
user: 'root',
pwd: 'root',
roles: [{role: 'root', db: 'admin'}]
});

db.updateUser("root", {
roles: [{role: 'root', db: 'admin'}, {role: 'dbAdmin', db: 'school'}, {role: 'readWrite', db: 'school'}]
})

db.getUser("school2")


db.createUser({
user: 'school2',
pwd: 'school2',
roles: [{role: 'dbAdmin', db: 'school'}, {role: 'readWrite', db: 'school'}]
});

db.createUser({
user: 'bookstore',
pwd: 'bookstore',
roles: [{role: 'dbAdmin', db: 'bookstore'}, {role: 'readWrite', db: 'bookstore'}]
});

db.getUser('bookstore')
