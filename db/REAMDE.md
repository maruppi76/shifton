## companies table
会社情報を管理するテーブル

### Model
Company

### Column Information
| Column | Type    | Options     |
| :----: | :-----: | :---------: |
| id(PK) |         |             |
| name   | string  | null: false |

### Association
- has_many :users
- has_many :departments


## departments table
部署を管理するテーブル

### Model
Department

### Column Information
| Column      | Type       | Options                        |
| :---------: | :--------: | :----------------------------: |
| id(PK)      |            |                                |
| name        | string     | null: false                    |
| ancestry    | string     |                                |
| company(FK) | references | null: false, foreign_key: true |

### Association
- belongs_to :company
- has_many :main_users, class_name: "User", foreign_key: "department_main_id"
- has_many :sub_users, class_name: "User", foreign_key: "department_sub_id"


## users table
ユーザーの情報を管理するテーブル

### Model
User

### Column Information
| Column               | Type       | Options                                              |
| :------------------: | :--------: | :--------------------------------------------------: |
| id(PK)               |            |                                                      |
| first_name           | string     | null: false                                          |
| last_name            | string     | null: false                                          |
| first_name_kana      | string     | null: false                                          |
| last_name_kana       | string     | null: false                                          |
| email                | Default    |                                                      |
| encrypted_password   | Default    |                                                      |
| staff_code           | string     |                                                      |
| status               | integer    | null: false                                          |
| company(FK)          | references | null: false, foreign_key: true                       |
| department_main (FK) | references | null: false, foreign_key: { to_table: :departments } |
| department_sub (FK)  | references | null: false, foreign_key: { to_table: :departments } |
| role                 | integer    | null: false                                          |
| admin                | boolean    | null: false, default: false                          |

### Association
- belongs_to :company
- belongs_to :department_main, class_name: "Department"
- belongs_to :department_sub, class_name: "Department"
- has_many :shifts
- has_many :shift_requests
- has_many :regal_holiday_requests


## patterns table
シフトパターンを管理するテーブル

### Model
Pattern

### Column Information
| Column              | Type    | Options     |
| :-----------------: | :-----: | :---------: |
| id(PK)              |         |             |
| pattern_type        | integer | null: false |
| name                | string  | null: false |
| start_time          | time    |             |
| end_time            | time    |             |
| break_time          | time    |             |
| actual_working_time | time    | null: false |
| remarks             | text    |             |

### Association
- has_many :shifts
- has_many :shift_requests
- has_many :regal_holiday_requests


## types table
シフトタイプを管理するテーブル

### Model
Type

### Column Information
| Column | Type    | Options     |
| :----: | :-----: | :---------: |
| id(PK) |         |             |
| name   | string  | null: false |

### Association
- has_many :shifts


## shifts table
シフト情報を管理するテーブル

### Model
Shift

### Column Information
| Column      | Type       | Options                        |
| :---------: | :--------: | :----------------------------: |
| id(PK)      |            |                                |
| date        | date       | null: false                    |
| user(FK)    | references | null: false, foreign_key: true |
| pattern(FK) | references | null: false, foreign_key: true |
| type(FK)    | references | foreign_key: true              |

### Association
- belongs_to :user
- belongs_to :pattern
- belongs_to :type


## shift_requests table
シフト希望を管理するテーブル

### Model
ShiftRequest

### Column Information
| Column      | Type       | Options                        |
| :---------: | :--------: | :----------------------------: |
| id(PK)      |            |                                |
| date        | date       | null: false                    |
| user(FK)    | references | null: false, foreign_key: true |
| pattern(FK) | references | null: false, foreign_key: true |
| status      | integer    | null: false, default: 0        |

### Association
- belongs_to :user
- belongs_to :pattern

## regal_holiday_requests table
有給休暇などの法定休暇希望を管理するテーブル

## Model
RegalHolidayRequest

### Column Information
| Column      | Type       | Options                        |
| :---------: | :--------: | :----------------------------: |
| id(PK)      |            |                                |
| date        | date       | null: false                    |
| user(FK)    | references | null: false, foreign_key: true |
| pattern(FK) | references | null: false, foreign_key: true |
| status      | integer    | null: false, default: 0        |

### Association
- belongs_to :user
- belongs_to :pattern