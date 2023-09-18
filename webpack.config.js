const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const ModuleFederationPlugin = require("webpack/lib/container/ModuleFederationPlugin");
const StandaloneSingleSpaPlugin = require("standalone-single-spa-webpack-plugin");
const packageJson = require("./package.json");
module.exports = {
  mode: "development",
  entry: path.resolve(process.cwd(), "build/web/main.dart.js"),
  devServer: {
    port: 8082,
  },
  plugins: [
    // new ModuleFederationPlugin({
    //   name: "microFrontEnd2",
    //   filename: "remoteEntry.js",
    //   exposes: {
    //     "./MicroFrontEnd2Index": "./build/web/main.dart.js",
    //   },
    // }),
    new HtmlWebpackPlugin({
      template: "./build/web/index.html",
    }),
    new CopyWebpackPlugin({
      patterns: [
        {
          from: "build/web/icons",
          to: "icons",
        },
        {
          from: "build/web/assets",
          to: "assets",
        },
        {
          context: "./build/web/",
          from: "**/*.js",
          to: "./",
        },
        {
          context: "./build/web/",
          from: "**/*.json",
          to: "./",
        },
      ],
    }),
  ],
};
