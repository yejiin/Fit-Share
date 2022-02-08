package com.fitshare.backend.common.exception;

import com.fitshare.backend.common.exception.handler.ErrorCode;

public class BusinessException extends RuntimeException{

    private ErrorCode errorCode;

    public BusinessException(String message) {
        super(message);
    }

    public BusinessException(ErrorCode errorCode) {
        super(errorCode.getMessage());
        this.errorCode = errorCode;
    }

    public ErrorCode getErrorCode() {
        return errorCode;
    }
}
