//
//  Post+Sql.swift
//  Greener
//
//  Created by Studio on 10/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation


extension Post{
    static func create_table(database: OpaquePointer?){
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        let res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS POSTS (POST_ID TEXT PRIMARY KEY, CONTENT TEXT, PICTURE TEXT, USER_ID TEXT)", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return
        }
    }
    
    func addToDb(){
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(ModelSql.instance.database,"INSERT OR REPLACE INTO POSTS (POST_ID, CONTENT, PICTURE, USER_ID) VALUES (?,?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            let id = self.id.cString(using: .utf8)
            let content = self.content.cString(using: .utf8)
            let picture = self.pic.cString(using: .utf8)
            let userId = self.userId.cString(using: .utf8)
            
            sqlite3_bind_text(sqlite3_stmt, 1, id,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, content,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, picture,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 4, userId,-1,nil);
            
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new post added succefully")
            }
        }
        sqlite3_finalize(sqlite3_stmt)
    }
    
    func Remove(){
        var sqlite3_stmt: OpaquePointer?
        if (sqlite3_prepare_v2(ModelSql.instance.database,"DELETE FROM POSTS WHERE POST_ID=?;", -1, &sqlite3_stmt,nil) == SQLITE_OK){
            let id = self.id.cString(using: .utf8)
           
            sqlite3_bind_text(sqlite3_stmt, 1, id,-1,nil);
            
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("post deleted succefully")
            }else{
                print("error deleting post")
            }
        }
        sqlite3_finalize(sqlite3_stmt)
    }
    
    static func getAllPostsFromDb()->[Post]{
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [Post]()
        
        if (sqlite3_prepare_v2(ModelSql.instance.database,"SELECT * from POSTS;",-1,&sqlite3_stmt,nil)
            == SQLITE_OK){
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let postId = String(cString:sqlite3_column_text(sqlite3_stmt,0)!)
                let post = Post(id: postId);
                post.content = String(cString:sqlite3_column_text(sqlite3_stmt,1)!)
                post.pic = String(cString:sqlite3_column_text(sqlite3_stmt,2)!)
                post.userId = String(cString:sqlite3_column_text(sqlite3_stmt,3)!)
                data.append(post)
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return data
    }
    
    static func setLastUpdate(lastUpdated:Int64){
        return ModelSql.instance.setLastUpdate(name: "POSTS", lastUpdated: lastUpdated);
    }
    
    static func getLastUpdateDate()->Int64{
        return ModelSql.instance.getLastUpdateDate(name: "POSTS")
    }
    
    static func ClearTable(callback:@escaping ()->Void){
        ModelSql.instance.clear();
        callback();
    }
}
