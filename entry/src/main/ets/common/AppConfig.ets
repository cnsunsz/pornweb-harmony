/**
 * Fixed server for PornWeb HarmonyOS client.
 * Matches Android fixed build / web backend; no server picker.
 */
export class AppConfig {
  /** Hardcoded HTTPS API origin (no trailing slash). */
  static readonly BASE_URL: string = 'https://web.cnsz.kdns.fr';

  /** Login path relative to BASE_URL (Android: POST api/auth/login). */
  static readonly LOGIN_PATH: string = '/api/auth/login';

  static loginUrl(): string {
    return AppConfig.BASE_URL + AppConfig.LOGIN_PATH;
  }
}
