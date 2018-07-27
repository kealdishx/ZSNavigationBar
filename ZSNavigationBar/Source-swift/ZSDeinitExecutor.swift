//
//  ZSDeinitExecutor.swift
//  ZSNavigationBar
//
//  Created by zakariyyasv on 2018/7/26.
//  Copyright © 2018年 Lingyue. All rights reserved.
//

import Foundation

class ZSDeinitExecutor {
  
  private var executorClosure: () -> Void
  
  init(executorClosure: @escaping () -> Void) {
    self.executorClosure = executorClosure
  }
  
  deinit {
    self.executorClosure()
  }
}
