class UserBean{
   int id;
  // 用户唯一标识符
   String useruid;
  // 姓名
   String username;
  // 密码
   String password;
  // 用户电话
   String phone;
  // 用户昵称
   String nike;
   String sign;

  // 用户头像
   String headerImagUrl;
  // 唯一校验码
  // 用户身份标识 0 超级管理员  1管理员  3 普通用户
   int identitys;

   String createTime;
   String createTimeStr;
  /**
   * 男1  女2
   */
   int gender;

  //其他用户是否关注
   bool isAttention;
}