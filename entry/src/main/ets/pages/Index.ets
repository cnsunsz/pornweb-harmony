import { AppConfig } from '../common/AppConfig';
import { AuthApi, AuthResponse } from '../network/AuthApi';

@Entry
@Component
struct Index {
  @State username: string = '';
  @State password: string = '';
  @State statusText: string = '未登录';
  @State busy: boolean = false;

  private async onLogin(): Promise<void> {
    const u = this.username.trim();
    if (u.length === 0 || this.password.length === 0) {
      this.statusText = '请输入用户名和密码';
      return;
    }
    this.busy = true;
    this.statusText = '登录中…';
    try {
      const res: AuthResponse = await AuthApi.login(u, this.password);
      const name = res.user?.username ?? u;
      const tokenOk = (res.access_token?.length ?? 0) > 0;
      this.statusText = tokenOk ? `登录成功：${name}` : `响应异常：无 access_token`;
    } catch (e) {
      const msg = e instanceof Error ? e.message : `${e}`;
      this.statusText = `登录失败：${msg}`;
    } finally {
      this.busy = false;
    }
  }

  build() {
    Column({ space: 16 }) {
      Text('PornWeb 鸿蒙版')
        .fontSize($r('app.float.page_title_font_size'))
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.text_primary'))
        .width('100%')

      Text(`服务器（固定）：${AppConfig.BASE_URL}`)
        .fontSize($r('app.float.page_body_font_size'))
        .fontColor($r('app.color.text_secondary'))
        .width('100%')

      Text(`登录接口：POST ${AppConfig.LOGIN_PATH}`)
        .fontSize(14)
        .fontColor($r('app.color.text_secondary'))
        .width('100%')

      TextInput({ placeholder: '用户名', text: this.username })
        .onChange((v: string) => {
          this.username = v;
        })
        .backgroundColor($r('app.color.field_bg'))
        .fontColor($r('app.color.text_primary'))
        .width('100%')

      TextInput({ placeholder: '密码', text: this.password })
        .type(InputType.Password)
        .onChange((v: string) => {
          this.password = v;
        })
        .backgroundColor($r('app.color.field_bg'))
        .fontColor($r('app.color.text_primary'))
        .width('100%')

      Button(this.busy ? '请稍候…' : '登录')
        .width('100%')
        .backgroundColor($r('app.color.accent'))
        .enabled(!this.busy)
        .onClick(() => {
          this.onLogin();
        })

      Text(this.statusText)
        .fontSize($r('app.float.page_body_font_size'))
        .fontColor($r('app.color.text_primary'))
        .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor($r('app.color.page_background'))
    .justifyContent(FlexAlign.Center)
  }
}
