package com.egor.marketplace.entity;

public enum Role {
    USER("USER"),
    ADMIN("ADMIN"),
    SELLER("SELLER");

    private final String value;

    Role(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public static Role fromString(String value) {
        for (Role role : Role.values()) {
            if (role.value.equalsIgnoreCase(value)) {
                return role;
            }
        }
        return USER;
    }
}
