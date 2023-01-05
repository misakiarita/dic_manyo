テーブル名:
データ型 :カラム名

- User 

| data       | colum           |
|:-----------|:----------------|
| string     | personal_id     |    
| string     | name            | 
| string     | password_digest | 

- Task

| data       | colum           |
|:-----------|:----------------|
| string     | title           |    
| string     | content         | 
| string     | priority        | 
| date       | deadline        |
| string     | status          |

- Label

| data       | colum           |
|:-----------|:----------------|
| string     | label_name      |    


- Herokuデプロイ

1\. $ heroku create
2\. $ bundle lock --add-platform x86_64-linux
3\. $ heroku stack:set heroku-20
4\. package.jsにnode.jsのバージョンを追記
5\. $ git addと$ git commit
6\. git push heroku dev_step2(自分の作用ブランチ):master