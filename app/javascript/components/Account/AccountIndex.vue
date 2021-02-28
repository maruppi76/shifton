<template>
  <div>
    <section>
      <div class="text-center text-lg-h4 mt-10 mb-10">アカウント情報</div>
    </section>
    <v-container>
      <v-row justify="center" class="mx-lg-16">
        <v-col cols="12" lg="10">
          <div class="BoxHeader text-body-1">
            アカウント
          </div>
          <div class="BoxBody">
            <table class="Table">
              <tbody>
                <tr>
                  <th>名前</th>
                  <td>{{ user.first_name}} {{ user.last_name }}</td>
                </tr>
                <tr>
                  <th>メールアドレス</th>
                  <td>{{ user.email }}</td>
                </tr>
                <tr>
                  <th>スタッフコード</th>
                  <td>{{ user.staff_code }}</td>
                </tr>
                <tr>
                  <th>アカウント権限</th>
                  <td>{{ user.role }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </v-col>
        <v-col cols="12" lg="10">
          <div class="BoxHeader text-body-1">
            会社情報
          </div>
          <div class="BoxBody">
            <table class="Table">
              <tbody>
                <tr>
                  <th>会社名</th>
                  <td>{{ user.company.name }}</td>
                </tr>
                <tr>
                  <th>所属部署<br/>（メイン）</th>
                  <td v-if="user.department_main" class="pc-text">{{ user.department_main.str }}</td>
                  <td v-else>未設定</td>
                  <td class="mobile-text">{{ user.department_main.mobile }}</td>
                </tr>
                <tr>
                  <th>所属部署<br/>（サブ）</th>
                  <td v-if="user.department_sub">{{ user.department_sub.str }}</td>
                  <td v-else>未設定</td>
                </tr>
              </tbody>
            </table>
          </div>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
  export default {
    props:['user']
  }
</script>

<style>
table {
  border-spacing: 0;
  border-collapse: collapse;
}

.BoxHeader {
  background-color: #fafafa;
  padding: 15px;
  border: solid 1px #dddddd;
  border-top-right-radius: 4px;
  border-top-left-radius: 4px;
}

.BoxBody {
  border: solid 1px #dddddd;
  border-bottom-left-radius: 4px;
  border-bottom-right-radius: 4px;
  border-top: none;
}

.Table {
  width: 100%;
  max-width: 100%;
}

.Table > tbody > tr {
  border-bottom: solid 1px #e0e0e0;
}

.Table > tbody > tr:last-child {
  border-bottom: none;
}

.Table > tbody > tr > th {
  width: 200px;
  max-width: 200px;
  vertical-align: middle;
  padding: 0 15px;
  height: 40px;
  background-color: #fafafa;
  font-size: 12px;
  font-weight: 500;
  text-align: center;
  border-right: solid 1px #e0e0e0;
}

.Table > tbody > tr > td {
  vertical-align: middle;
  height: 50px;
  padding: 0 15px;
  border: none;
  font-size: 13px;
  font-weight: 500;
  background-color: #fff;
}

.mobile-text {
  display: none;
}

@media screen and (max-width: 600px) {
  .Table > tbody > tr > th {
    width: 40%;
  }

  .pc-text {
    display: none;
  }

  .mobile-text {
    display: revert;
  }
}
</style>