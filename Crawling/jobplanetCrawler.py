import re
import lxml.html    
import requests 
import MySQLdb
from robobrowser import RoboBrowser
from werkzeug.utils import cached_property

conn = MySQLdb.connect(db='Crawler', user='cloud', passwd='1111', charset='utf8mb4')

c=conn.cursor()

browser = RoboBrowser(parser='html.parser')

browser.open('https://www.jobplanet.co.kr/welcome/index_new')

select_sql = 'SELECT company FROM re_info'
c.execute(select_sql)

for row in c.fetchall():
    for i in range(len(row)):

        form = browser.get_form(action='/search')
        form['query'] = row[i]
        company = row[i]
        browser.submit_form(form, list(form.submit_fields.values()))

        link = browser.select('.is_company_card div > a')
        if link:
            detail_link = link[0].get('href')
            detail_link = 'https://www.jobplanet.co.kr' + detail_link

            detail_page = requests.get(detail_link)
            page = lxml.html.fromstring(detail_page.content)
            #star = page.cssselect('body > div.body_wrap > div.cmp_hd > div.new_top_bnr > div > div.top_bnr_wrap > div > div > div.company_info_sec > div.company_info_box > div.about_company > div.grade.jply_ico_star>span')
            star = page.cssselect('.grade > span')
            
            print(star[0].text)

            if star:
                star = star[0].text
            if not star:
                star = 0.0
            company_star = float(star)

            update_sql = 'UPDATE re_info SET star = %s WHERE company = %s'

            update_val = company_star, company

            c.execute(update_sql, update_val)

            conn.commit()

conn.close()
