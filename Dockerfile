
# ============ Runtime stage (nginx) ============
FROM public.ecr.aws/nginx/nginx:1.29-alpine

# SPAルーティング用のnginx設定
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# distのコピー（プロジェクト名は環境に合わせて修正/自動化）
# よくある構成: dist/<project-name>/browser/
# ビルド段階で環境変数を渡したい場合は --build-arg を使ってください。
ARG DIST_DIR="./dist/demo-page/browser"
COPY --from=build ${DIST_DIR}/ /usr/share/nginx/html/

# ヘルスチェック用
RUN echo "ok" > /usr/share/nginx/html/healthz

# ポート
EXPOSE 80

# デフォルトのnginx起動（CMDはベースイメージに定義済み）
