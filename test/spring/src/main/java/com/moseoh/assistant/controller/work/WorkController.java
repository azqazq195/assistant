package com.moseoh.assistant.controller.work;

import com.moseoh.assistant.controller.work.dto.WorkDto;
import com.moseoh.assistant.response.Response;
import com.moseoh.assistant.response.SuccessCode;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("/work")
public class WorkController {

//    @GetMapping("/{id}")
//    public ResponseEntity<Response<WorkDto>> retrive(@PathVariable int id) {
//        return ResponseEntity.ok().body(
//          new Response<>(
//                  SuccessCode.SCRAP,
//                  workService.retrive
//          )
//        );
//    }
}
