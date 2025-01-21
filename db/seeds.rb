# очищение бд перед заполнением
User.destroy_all
Project.destroy_all
Task.destroy_all

# создание пользователей
users = User.create!([
  { name: "Иван", email: "ivan@example.com" },
  { name: "Анна", email: "anna@example.com" },
  { name: "Сергей", email: "sergey@example.com" }
])

# создание проектов
projects = Project.create!([
  { title: "Разработка веб-приложения", description: "Создание проекта на Rails" },
  { title: "Мобильное приложение", description: "Разработка iOS/Android-приложения" }
])

# создание задач и связывание с проектами и пользователями
Task.create!([
  { title: "Настроить базу данных", description: "Создать и настроить PostgreSQL", due_date: "2024-02-01", status: "Новая", project: projects[0], assignee: users[0] },
  { title: "Разработать API", description: "Создать REST API для приложения", due_date: "2024-02-05", status: "В процессе", project: projects[0], assignee: users[1] },
  { title: "Дизайн интерфейса", description: "Разработать UI/UX", due_date: "2024-02-10", status: "Завершена", project: projects[1], assignee: users[2] }
])