# Откройте https://demo.us.espocrm.com/ и добавьте ожидание, выберите 1-й язык из списка: English(UK) и нажмите "Login"
import time
from selenium import webdriver
from selenium.webdriver.support.select import Select
driver = webdriver.Chrome(executable_path='C:/chromedriver-win64/chromedriver-win64/chromedriver.exe')
driver.maximize_window()
driver.get("https://demo.us.espocrm.com/")
time.sleep(3)
element = driver.find_element_by_id("field-language")
select = Select(element)
select.select_by_value("en_GB")
login = driver.find_element_by_id("btn-login")
login.click()
time.sleep(3)
# В меню слева нажмите на раздел "Activities"
my_activities = driver.find_element_by_link_text('My Activities')
my_activities.click()
time.sleep(3)
# Нажмите на "Tasks". Добавьте ожидание. Слева от поиска нажмите на селектор "All"
tasks = driver.find_element_by_css_selector('[href="#Task"]')
tasks.click()
time.sleep(3)
all = driver.find_element_by_class_name('filters-label')
all.click()
# Отметьте чекбокс "Only My"
only_my = driver.find_element_by_css_selector("li.checkbox:nth-child(11)")
only_my.click()
time.sleep(3)
# Отметьте чекбокс для выбора всех задач
all_tasks = driver.find_element_by_class_name('select-all-container')
all_tasks.click()
time.sleep(3)
# Нажмите на "Actions", выберите пункт "Mass Update"
actions = driver.find_element_by_class_name('btn.btn-default.btn-xs-wide.dropdown-toggle.actions-button')
actions.click()
time.sleep(3)
mass_update = driver.find_element_by_link_text("Mass Update")
mass_update.click()
time.sleep(3)
# С помощью if, проверьте, что кнопка "Update" недоступна для выбора. Затем закройте окно через крестик и добавьте ожидание
update_button = driver.find_element_by_class_name('btn.btn-danger.btn-xs-wide.disabled.radius-left')
update_button_checked = update_button.get_attribute("checked")
print("value of checkbox: ", update_button_checked)
if update_button_checked is None:
    print("кнопка не нажимается")
else:
    print("кнопка нажимается")
driver.find_element_by_class_name('close').click()
time.sleep(3)
# Нажмите на "Create Task" и добавьте ожидание 5 секунд. Затем заполните поле "Name" значением: "Test". 
create_task = driver.find_element_by_link_text('Create Task')
create_task.click()
time.sleep(5)
name = driver.find_element_by_class_name('main-element.form-control')
name.click()
name.send_keys("Test")
# В селекторе "Status", проверьте, что в "Status" выбрано значение "Not Started". 
status = driver.find_element_by_css_selector(".col-sm-6:nth-child(1) select")
status_not_started = status.get_attribute("value")
if status_not_started == "Not Started":
    print('ok')
else:
    print('not ok', status_not_started)
# Нажмите на кнопку Save и добавьте ожидание. Нажмите на ссылку "Tasks" (над кнопкой "Edit") и добавьте ожидание
save = driver.find_element_by_css_selector(".btn-xs-wide:nth-child(1)")
save.click()
time.sleep(3)
tasks = driver.find_element_by_css_selector('[data-action="navigateToRoot"]')
tasks.click()
time.sleep(3)
# Выберите чекбокс первой задачи в списке
checkbox_first_task = driver.find_element_by_css_selector(".list-row:nth-child(1) .record-checkbox.form-checkbox.form-checkbox-small")
checkbox_first_task.click()
time.sleep(3)
# После выбора появится кнопка "Actions". Снова создайте в коде переменную для этой кнопки и нажмите на неё
actions = driver.find_element_by_class_name('btn.btn-default.btn-xs-wide.dropdown-toggle.actions-button')
actions.click()
time.sleep(3)
# В списке "Actions" выберите пункт "Remove"
remove = driver.find_element_by_link_text("Remove")
remove.click()
time.sleep(3)
driver.quit()
