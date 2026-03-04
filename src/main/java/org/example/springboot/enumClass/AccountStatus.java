package org.example.springboot.enumClass;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;

@Getter
public enum AccountStatus {
    @Schema(description = "") PENDING_REVIEW("PENDING_REVIEW"),
    @Schema(description = "") REVIEW_SUCCESS("REVIEW_SUCCESS"),
    @Schema(description = "") REVIEW_FAILED("REVIEW_FAILED");

    private final String value;

    AccountStatus(String value) {
        this.value = value;
    }

}