Great! Here’s the final version of your README text in proper Markdown format, ready to use on GitHub:

# 📦 Database Management System

This project provides SQL scripts for managing a comprehensive database system tailored for farm operations. It supports user roles, blog content, and detailed records for animals, employees, cages, food supplies, and more. Additionally, it includes procedures and triggers for dynamic management of employee-animal assignments, salary validations, and cage updates.

---

## 🐄 Topic Description

The system handles the following aspects:

1. **Animal Management** – Tracks species, names, and arrival dates.
2. **Cage Management** – Records cage types and housed animals.
3. **Employee Management** – Stores staff names, ages, and email contacts.
4. **Employee Positions** – Manages job titles, hire dates, and salaries.
5. **Animal Care** – Logs which employees care for which animals, along with care types and dates.
6. **Food Management** – Maintains food types, suppliers, and pricing.
7. **Animal Feeding** – Documents which animals receive specific foods.
8. **Supplier Management** – Stores supplier contact details and service start dates.

---

## 🗃️ Database Structure

The database includes the following core tables:

- **`role`** – Contains role `id` and `name`.
- **`user`** – Contains user `id` and `email`.
- **`user_roles`** – Maps users to roles using `user_id` and `role_id`.
- **`blog`** – Stores blog `id`, `name`, and `manager_id`.
- **`article`** – Stores article `id`, `title`, `author_id`, and `blog_id`.
