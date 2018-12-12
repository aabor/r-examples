library('RSelenium')
rd <- rsDriver(remoteServerAddr = 'selenium', port = 4444L, verbose = TRUE, browser = 'firefox')
#rd <- rsDriver(remoteServerAddr = 'selenium', port = 4444L, verbose = TRUE, browser = 'phantomjs')

# Выбираем объект-браузер
browser <- rd$client

# Задаем интервал времени
start <- "01/01/2017";
end <- "01/02/2017"

# Переходим на нужную страницу
browser$navigate("https://ru.investing.com/commodities/lead-historical-data?cid=959207")
browser$screenshot(display = TRUE)
# Выбираем искомый виджет
data_range <- browser$findElement(using = "css selector", "#widgetFieldDateRange")
# Кликаем по нему, чтобы раскрыть
data_range$clickElement()
browser$screenshot(display = TRUE)
# Находим начальную дату
sd <- browser$findElement(using = "css selector", "#startDate")
# Очищаем поле
sd$clearElement()
# Вводим нужную дату
sd$sendKeysToElement(list(start))
browser$screenshot(display = TRUE)
# Проделываем аналогичные операции с конечной датой
ed <- browser$findElement(using = "css selector", "#endDate")
ed$clearElement()
ed$sendKeysToElement(list(end))
browser$screenshot(display = TRUE)

# Находим кнопку оправки дат
btn <- browser$findElement(using = "css selector", "#applyBtn")
# Кликаем по ней
btn$clickElement()
browser$screenshot(display = TRUE)

# Сформированную таблицу средствами rvest
library(rvest)
page <- read_html(unlist(browser$getPageSource()))
tbl <- html_node(page, "#curr_table")
html_table(tbl)
browser$screenshot(display = TRUE)

# Закрываем браузер
browser$close()
# Останавливаем сервер
rd$server$stop()
