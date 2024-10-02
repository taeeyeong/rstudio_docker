# Dockerfile
FROM rocker/rstudio:4.4.0

# 시스템 패키지 업데이트 및 필수 라이브러리 설치
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 사용자 라이브러리 디렉토리 생성 및 권한 설정
RUN mkdir -p /home/jovyan/R/library && \
    chown -R jovyan:jovyan /home/jovyan/R/library

# 환경 변수 설정
ENV R_LIBS_USER=/home/jovyan/R/library

# (선택 사항) 필요한 R 패키지 사전 설치
RUN R -e "install.packages(c('XVector', 'SparseArray', 'GenomicRanges', 'DelayedArray', 'SummarizedExperiment', 'DESeq2'), lib='/home/jovyan/R/library', repos='http://cran.rstudio.com/')"