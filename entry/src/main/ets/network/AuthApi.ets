import { http } from '@kit.NetworkKit';
import { AppConfig } from '../common/AppConfig';

export interface LoginRequestBody {
  username: string;
  password: string;
}

export interface AuthUser {
  id?: number;
  username?: string;
  email?: string;
  is_admin?: boolean;
  avatar?: string;
  created_at?: string;
}

export interface AuthResponse {
  access_token?: string;
  token_type?: string;
  user?: AuthUser;
}

export class AuthApi {
  static async login(username: string, password: string): Promise<AuthResponse> {
    const body: LoginRequestBody = { username, password };
    const client = http.createHttp();
    try {
      const response = await client.request(AppConfig.loginUrl(), {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        extraData: JSON.stringify(body),
        expectDataType: http.HttpDataType.STRING,
        connectTimeout: 15000,
        readTimeout: 20000
      });

      const code = response.responseCode;
      const raw = typeof response.result === 'string' ? response.result : `${response.result}`;
      if (code < 200 || code >= 300) {
        let detail = raw;
        try {
          const errObj = JSON.parse(raw) as Record<string, string>;
          if (errObj['detail']) {
            detail = errObj['detail'];
          }
        } catch (_e) {
          // keep raw body
        }
        throw new Error(`HTTP ${code}: ${detail}`);
      }
      return JSON.parse(raw) as AuthResponse;
    } finally {
      client.destroy();
    }
  }
}
