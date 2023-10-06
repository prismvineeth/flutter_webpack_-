const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const ModuleFederationPlugin = require("webpack/lib/container/ModuleFederationPlugin");
const StandaloneSingleSpaPlugin = require("standalone-single-spa-webpack-plugin");
const { CleanWebpackPlugin } = require('clean-webpack-plugin');  
const packageJson = require("./package.json");
const isAnyOf = (value, list) => list.includes(value);

module.exports = (env, argv) => {
  let prodMode = argv?.p || argv?.mode === "production";
  return {
  mode: prodMode ? "production" : "development",
  entry: path.resolve(process.cwd(), "build/web/index.js"),
  output: {
    filename: `index.js`,
    libraryTarget: "system",
    path: path.resolve(process.cwd(), "dist"),
    uniqueName: packageJson.name,
    publicPath: "",
  },
  module: {
    rules: [
      {
        parser: {
          system: false,
        },
      },
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
        },
      },
      {
        test: /\.html$/i,
        use: ["html-loader"],
      },
      {
        test: /\.css$/i,
        use: [
          "style-loader",
          {
            loader: "css-loader",
            options: {
              importLoaders: 1,
              modules: true,
            },
          },
          {
            loader: "postcss-loader",
          },
        ],
      },
    ],
  },
  devtool: "source-map",
  devServer: {
    port: 8083,
    compress: true,
    historyApiFallback: true,
    headers: {
      "Access-Control-Allow-Origin": "*",
    },
    onListening: function ({
      server /* https://nodejs.org/api/net.html#class-netserver */,
      compiler,
    }) {
      if (!server)
        throw new Error("webpack-dev-server is missing a server instance");

      // config values
      const { port: serverPort, address } = server.address();
      const { publicPath, filename } = compiler.options.output;

      // derived values
      const protocol = compiler.options.devServer.https
        ? "https://"
        : "http://";
      const host = address === "::" ? "localhost" : address;
      const port = Boolean(serverPort) ? `:${serverPort}` : "";
      const path = isAnyOf(publicPath, ["", "auto"]) ? "/" : publicPath;

      console.log(
        `\n  ⚡️ single-spa application entry: ${protocol}${host}${port}${path}${filename}\n`
      );
    },
  },
  plugins: [
    // new ModuleFederationPlugin({
    //   name: "microFrontEnd2",
    //   filename: "remoteEntry.js",
    //   exposes: {
    //     "./MicroFrontEnd2Index": "./build/web/main.dart.js",
    //   },
    // }),
    new CleanWebpackPlugin({
      cleanAfterEveryBuildPatterns: ['dist'],
    }),
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
          globOptions: {
            ignore: [
                '**/NOTICES',
            ]
        }
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
        {
          context: "./build/web/",
          from: "**/*.png",
          to: "./",
        }
      ],
    }),
    new StandaloneSingleSpaPlugin({
      appOrParcelName: packageJson.name,
      disabled: false,
    }),
  ], // .filter(Boolean),
  externals: ["single-spa"],
}};
