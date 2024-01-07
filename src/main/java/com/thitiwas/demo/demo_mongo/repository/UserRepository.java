package com.thitiwas.demo.demo_mongo.repository;

import com.thitiwas.demo.demo_mongo.entity.UserEntity;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface UserRepository extends MongoRepository<UserEntity, String> {

    public UserEntity findByEmail(String email);

    // List<UserEntity> find();
}
