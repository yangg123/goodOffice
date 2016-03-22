//
//  Enum.h
//  Yeke
//
//  Created by yangg on 15/7/13.
//  Copyright (c) 2015年 西米网络科技. All rights reserved.
//

#ifndef Yeke_Enum_h
#define Yeke_Enum_h

typedef enum {
    NoInputState,       //无键盘、无输入状态（一开始状态）
    InputShowState,    //输入展示状态
    RecordState,      //通话记录
    InputHideState   //输入隐藏状态，也处于通话状态
} ItemState;

typedef enum {
    WhiteColor = 1,    //f0f2f5,白色
    GreenColor,       //00bf8f，绿色
    GrayColor        //727a83,灰色
} ItemTitleColor;

typedef enum {
    registerPwd , //注册
    forgetPwd,   //忘记密码
} PwdType;

typedef enum {
    NewGroup,
    MyGroup,
} AddGroupType;           //分组类型


typedef enum {
    DirectCall,        //电话号码直播，如果被呼叫的号码在通讯录里面则改为通讯录呼叫
    SingleCall,        //通讯录单独呼叫
    GroupCall          //多人通话
} CallType;            //呼叫类型

typedef enum {
    WithRecord,          //已经知道的联系人、而且有过通话记录
    NoRecord,           //无通话记录的
} RecordDetailType;     //呼叫类型

#endif




