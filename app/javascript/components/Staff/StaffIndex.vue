<template>
  <v-app>
    <v-card elevation="0" class="rounded-0">
      <v-card-title
        class="blue-grey lighten-5"
      >スタッフ一覧</v-card-title>
    </v-card>
    <v-row class="ma-0 align-content-start">
      <v-col cols="4" lg="1" v-for="n in 20" :key="n">
        <v-card
          elevation="0"
          tile
        >
          <v-img
            class="rounded-circle"
            :aspect-ratio="1/1"
            width="200px"
            src="https://picsum.photos/id/11/500/300"
          ></v-img>
          <div class="text-center my-3">
            山田 太郎
          </div>
        </v-card>
      </v-col>
    </v-row>
  </v-app>
</template>