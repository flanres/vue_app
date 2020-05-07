<template>
  <v-card class="elevation-1 pa-3 login-card">
    <v-card-text>
      <div class="layout column align-center">
        <h1 class="flex my-4 primary--text font-weight-bold">ログイン</h1>
      </div>
      <v-form ref="loginForm">
        <v-text-field
          append-icon="person"
          name="login"
          label="メールアドレス"
          type="text"
          v-model="model.email"
          :counter="128"
          :rules="emailRules"
          required
        ></v-text-field>
        <v-text-field
          append-icon="lock"
          name="password"
          label="パスワード"
          id="password"
          type="password"
          v-model="model.password"
          :counter="32"
          :rules="passwordRules"
          required
        ></v-text-field>
      </v-form>
    </v-card-text>
    <div class="login-btn">
      <v-btn block color="primary" @click="login" :loading="loading">ログイン</v-btn>
    </div>
  </v-card>
</template>

<script>
import Axios from "axios"
export default {
  data: () => ({
    loading: false,
    emailRules: [
      v => !!v || "メールアドレスは必須項目です。",
      v => (v && v.length <= 128) || "メールアドレスは128文字以内で入力してください。",
      v => /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(v) || "メールアドレスの形式が正しくありません。"
    ],
    passwordRules: [
      v => !!v || "パスワードは必須項目です。",
      v => (v && v.length <= 32) || "パスワードは32文字以内で入力してください。"
    ],
    model: {
      email: "",
      password: ""
    }
  }),

  methods: {
    login() {
      // バリデーションが通った場合
      if (this.$refs.loginForm.validate()) {
        // ぐるぐる表示にしてボタンを二度押しできなくする
        this.loading = true
        // APIでログイン認証を行う
        Axios.post("/api/auth/login", this.model).then(res => {
          // 成功した場合
          if (res.data.result) {
            // ログイン情報を store に保存
            this.$store.dispatch("setLoginInfo", res.data)
            // 元の画面に戻る
            this.$router.push({path: "backuri" in this.$route.query && this.$route.query.backuri.match(/^\//) ? this.$route.query.backuri : '/'})
          // メールアドレスとパスワードが正しくない組み合わせだった場合
          } else {
            this.loading = false
            alert(Object.values(res.data.errors).join("\n"))
          }
        }).catch(error => {
          alert("処理が正しく行えませんでした。時間をおいてやり直してください。")
          this.loading = false
        })
      }
    }
  }
}
</script>