//
//  YDBuilderSQLController.swift
//  YDKit
//
//  Created by 王允顶 on 2018/8/16.
//  Copyright © 2018年 王允顶. All rights reserved.
//

import UIKit

class YDBuilderSQLController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var filePath: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filePath = Bundle.main.path(forResource: "YDTableInfo", ofType: "orm.xml")
        self.setBaseParameter()
        self.view.addSubview(self.sqlLabel)
        self.view.addSubview(self.tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    lazy var sqlLabel: UILabel = {
        let label: UILabel = UILabel(frame: CGRect(x: 13, y: 80, width: self.view.frame.size.width - 30, height: 60))
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    lazy var tableView: UITableView = {
        let table: UITableView = UITableView(frame: CGRect(x: 0, y: 150, width: self.view.frame.size.width, height: self.view.frame.size.height - 150), style: UITableView.Style.plain)
        table.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.delegate = self
        table.dataSource = self
        return table
    }()
    lazy var titleList: [String] = {
        let list: [String] = ["测试壹 - 查询语句","测试贰 - 查询排序","测试叁 - 插入","测试肆 - 批量插入","测试伍 - 测试Dao","测试陆 - 测试创建数据库","测试柒 - 删除操作","测试捌 - 查询操作","测试玖 - 其他条件查询","测试拾 - 数据更新"]
        return list
    }()

}

extension YDBuilderSQLController {
    func setBaseParameter() {
        self.navigationItem.title = "构建者模式SQL"
        self.view.backgroundColor = UIColor.white
    }
}

//MARK: - UITableViewDataSource
extension YDBuilderSQLController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleList.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        cell.textLabel?.text = self.titleList[indexPath.row]
        cell.textLabel?.textAlignment = NSTextAlignment.center
        cell.textLabel?.textColor = UIColor.orange
        cell.backgroundColor = UIColor.clear
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.sqlTest(indexPath.row)
    }
}

//MARK: - SQL 语句测试
extension YDBuilderSQLController {
    func sqlTest(_ number: Int) {
        switch number {
        case 0:
            self.testOne()
        case 1:
            self.testSecond()
        case 2:
            self.testThree()
        case 3:
            self.testFour()
        case 4:
            self.testFive()
        case 5:
            self.testSix()
        case 6:
            self.testSeven()
        case 7:
            self.testEight()
        case 8:
            self.testNine()
        case 9:
            self.testTen()
        default:
            self.testOne()
        }
    }
    //测试一 - 查询语句
    func testOne() {
        let selectSQLBuilder = YDSQLSelectBuilder()
        var wh = [String: Any]()
        wh["tableId"] = 2
        wh["tableName"] = "zhangsan"
        wh["tableAge"] = 20
        let sql: String = selectSQLBuilder.select().all().from().table("student").wh().whAnd(wh).build()
        self.sqlLabel.text = sql;
        print("SQL: " + sql)
    }
    //测试二 - 查询排序
    func testSecond() {
        let selectSQLBuilder = YDSQLSelectBuilder()
        var wh = [String: Any]()
        wh["tableAge"] = 20
        wh["tableId"] = "2"
        wh["tableName"] = "zhangsan"
        
        let sql: String = selectSQLBuilder.selectAllFromTableWhereForma(table: "student", wh: wh).orderBy("tableAge").orderByAsc().build()
        self.sqlLabel.text = sql
        print("SQL: " + sql)
    }
    //测试三 - 插入
    func testThree() {
        var colums = Array<String>()
        colums.append("tableId")
        colums.append("tableAge")
        colums.append("tableName")
        
        var values = Array<Any>()
        values.append("11")
        values.append(18)
        values.append("zhangsan")
        
        let insert = YDSQLInsertBuilder()
        let sql = insert.insert().into().table("student").colums(colums).values(values).build()
        self.sqlLabel.text = sql
        print("SQL: " + sql)
    }
    //测试四 批量插入
    func testFour() {
        var colums = Array<String>()
        colums.append("tableId")
        colums.append("tableAge")
        colums.append("tableName")
        
        var values = Array<Array<Any>>()
        var values1 = Array<Any>()
        values1.append(12)
        values1.append("lisi")
        values1.append(19)
        values.append(values1)
        
        var values2 = Array<Any>()
        values2.append(13)
        values2.append("wanger")
        values2.append(20)
        values.append(values2)
        
        let insert = YDSQLInsertBuilder()
        let sql = insert.insert().into().table("student").colums(colums).batchValues(values).build()
        self.sqlLabel.text = sql
        print("SQL: " + sql)
    }
    //测试五 测试DAO - 创建数据库
    func testFive() {
        YDTableTemplateConfig.sharedInstace.initXml(self.filePath!)
        let helper = YDOrmSQLiteOpenHelper()
        
        let baseDao = YDBaseDao<YDTableInfo>(helper: helper)
        let tableInfo = YDTableInfo()
        tableInfo.tableId = 2
        tableInfo.tableName = "teacher"
        tableInfo.tableAge = 25
        let result = baseDao.insert(obj: tableInfo)
        
        self.sqlLabel.text = String(result)
        print("结果：\(result)")
    }
    //测试六 - 测试创建数据库
    func testSix() {
        YDTableTemplateConfig.sharedInstace.initXml(self.filePath!)
        let helper = YDOrmSQLiteOpenHelper()
        let baseDao = YDBaseDao<YDTableInfo>(helper: helper)
        let tableInfo = YDTableInfo()
        tableInfo.tableId = 1
        tableInfo.tableName = "student"
        tableInfo.tableAge = 20
        let result = baseDao.insert(obj: tableInfo)
        
        self.sqlLabel.text = String(result)
        print("结果：\(result)")
    }
    //测试七 - 删除操作
    func testSeven() {
        YDTableTemplateConfig.sharedInstace.initXml(self.filePath!)
        let helper = YDOrmSQLiteOpenHelper()
        let dao = YDBaseDao<YDTableInfo>(helper: helper)
        let tableInfo = YDTableInfo()
        tableInfo.tableId = 1
        tableInfo.tableName = "student"
        tableInfo.tableAge = 20
        let result = dao.delete(obj: tableInfo)
        
        self.sqlLabel.text = String(result)
        print("结果：\(result)")
    }
    //测试八 - 查询操作
    func testEight() {
        YDTableTemplateConfig.sharedInstace.initXml(self.filePath!)
        let helper = YDOrmSQLiteOpenHelper()
        let dao = YDBaseDao<YDTableInfo>(helper: helper)
        let result = dao.selectAll()
        for item in result {
            print("用户ID：\(item.tableId) :||: 用户名：\(item.tableName) :||: 用户年龄：\(item.tableAge)")
        }
    }
    //测试九
    func testNine() {
        YDTableTemplateConfig.sharedInstace.initXml(self.filePath!)
        let helper = YDOrmSQLiteOpenHelper()
        let dao = YDBaseDao<YDTableInfo>(helper: helper)
        
        let tableInfo = dao.select(id: 1)
        
        print("用户ID：\(tableInfo.tableId) :||: 用户名：\(tableInfo.tableName) :||: 用户年龄：\(tableInfo.tableAge)")
        

        var wh = [String: Any]()
        wh["tableName"] = "student"
        let array = dao.select(wh: wh)
        for item in array {
            print("用户ID：\(item.tableId) :||: 用户名：\(item.tableName) :||: 用户年龄：\(item.tableAge)")
        }
    }
    //测试十 测试数据更新
    func testTen() {
        YDTableTemplateConfig.sharedInstace.initXml(self.filePath!)
        let helper = YDOrmSQLiteOpenHelper()
        let dao = YDBaseDao<YDTableInfo>(helper: helper)
        let tableInfo = YDTableInfo()
        tableInfo.tableId = 2
        tableInfo.tableName = "teacher"
        tableInfo.tableAge = 30
        let result = dao.update(obj: tableInfo)
        
        print("更新结果： \(result)")
        
    }
    
}
