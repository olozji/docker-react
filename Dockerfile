# Node.js 이미지를 기반으로 합니다.
FROM node:14

# 작업 디렉토리 설정
WORKDIR /app

# 패키지 파일을 복사
COPY package.json ./

# 필요한 패키지 설치
RUN npm install

# 애플리케이션 소스 코드를 복사
COPY . .

# 애플리케이션을 빌드
RUN npm run build

# Nginx 이미지를 사용하여 빌드된 파일을 서빙
FROM nginx:alpine
COPY --from=0 /app/build /usr/share/nginx/html

# Nginx 설정 파일을 복사
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Nginx가 수신 대기할 포트를 정의합니다.
EXPOSE 80

# Nginx를 실행합니다.
CMD ["nginx", "-g", "daemon off;"]
