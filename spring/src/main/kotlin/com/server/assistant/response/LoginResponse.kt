package com.server.assistant.response

/**
 * LoginResponse
 * 주소
 * GitHub : http://github.com/azqazq195
 * Created by azqazq195@gmail.com on 2021-10-31
 */
enum class Result{
    SUCCESS, FAILURE
}

data class LoginResponse(
    val id: Long?,
    val message: String?,
    val result: String,
)