package com.thitiwas.demo.demo_mongo.service;

import com.thitiwas.demo.demo_mongo.entity.UserEntity;
import com.thitiwas.demo.demo_mongo.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.aggregation.MatchOperation;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Service;

import java.util.List;

import static org.springframework.data.mongodb.core.aggregation.Aggregation.match;
import static org.springframework.data.mongodb.core.aggregation.Aggregation.newAggregation;

@Service
@Slf4j
public class UserService {

    private final MongoTemplate mongoTemplate;

    private final UserRepository userRepository;

    @Autowired
    public UserService(MongoTemplate mongoTemplate, UserRepository userRepository) {
        this.mongoTemplate = mongoTemplate;
        this.userRepository = userRepository;
    }

    public UserEntity findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public List<UserEntity> findAll() {
        return userRepository.findAll();
    }

    public List<UserEntity> nativeFindAll() {
        MatchOperation filterStates = match(new Criteria("email").is("thitiwas.n@gmail.com"));
        Aggregation aggregation = newAggregation(filterStates);
        AggregationResults<UserEntity> output
                = mongoTemplate.aggregate(aggregation, "m_user", UserEntity.class);
        return output.getMappedResults();
    }

    public String nativeFindAllV2() {
        MatchOperation filterStates = match(new Criteria("email").is("thitiwas.nn@gmail.com"));
        Aggregation aggregation = newAggregation(filterStates);
        AggregationResults<String> output
                = mongoTemplate.aggregate(aggregation, "m_user", String.class);
        String json = output.getRawResults().toJson();
        log.info("output :{}" , json);
        return json;
    }
}
