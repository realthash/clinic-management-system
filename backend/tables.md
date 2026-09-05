## Table `hospital`

### Columns

| Name           | Type        | Constraints |
| -------------- | ----------- | ----------- |
| `id`           | `uuid`      | Primary     |
| `name`         | `varchar`   |             |
| `address`      | `varchar`   |             |
| `phone_number` | `varchar`   | Unique      |
| `created_at`   | `timestamp` |             |
| `updated_at`   | `timestamp` | Nullable    |

## Table `clinic`

### Columns

| Name              | Type        | Constraints |
| ----------------- | ----------- | ----------- |
| `id`              | `uuid`      | Primary     |
| `name`            | `varchar`   |             |
| `hospital_id`     | `uuid`      |             |
| `venue`           | `varchar`   |             |
| `session_date`    | `date`      |             |
| `contact_details` | `varchar`   | Nullable    |
| `created_at`      | `timestamp` |             |
| `updated_at`      | `timestamp` | Nullable    |

## Table `clinic_sessions`

### Columns

| Name              | Type        | Constraints |
| ----------------- | ----------- | ----------- |
| `id`              | `uuid`      | Primary     |
| `clinic_id`       | `uuid`      |             |
| `name`            | `varchar`   |             |
| `venue`           | `varchar`   |             |
| `session_date`    | `date`      |             |
| `contact_details` | `varchar`   | Nullable    |
| `created_at`      | `timestamp` |             |
| `updated_at`      | `timestamp` | Nullable    |

## Table `users`

### Columns

| Name                | Type        | Constraints |
| ------------------- | ----------- |:----------- |
| `id`                | `uuid`      | Primary     |
| `hospital_id`       | `uuid`      |             |
| `name`              | `varchar`   |             |
| `email`             | `varchar`   | Unique      |
| `phone_number`      | `varchar`   | Unique      |
| `role`              | `varchar`   |             |
| `created_at`        | `timestamp` |             |
| `updated_at`        | `timestamp` | Nullable    |
| `clinic_session_id` | `uuid`      | Nullable    |
