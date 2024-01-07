package com.thitiwas.demo.demo_mongo.controller;

import com.thitiwas.demo.demo_mongo.entity.UserEntity;
import com.thitiwas.demo.demo_mongo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController("/home")
public class HomeController {
    private final UserService userService;

    @Autowired
    public HomeController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/t")
    public ResponseEntity<String> test() {
        return ResponseEntity.ok("test");
    }

    @GetMapping("/email")
    public ResponseEntity<UserEntity> testFindByEmail(){
        String email = "thitiwas.n@gmail.com";
        return ResponseEntity.ok(userService.findByEmail(email));
    }

    @GetMapping("/all")
    public ResponseEntity<List<UserEntity>> testFindAll(){
        return ResponseEntity.ok(userService.findAll());
    }

    @GetMapping("/n_all")
    public ResponseEntity<List<UserEntity>> nativeFindAll(){
        return ResponseEntity.ok(userService.nativeFindAll());
    }
    @GetMapping("/s_all")
    public ResponseEntity<String> nativeFindAllV2(){
        return ResponseEntity.ok(userService.nativeFindAllV2());
    }
}
