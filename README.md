# 使用devpi部署本地pypi缓存源

## 部署方式
```
docker-compose up -d --build
```

## 使用方式

### 本地临时使用

```
pip install -i http://192.168.10.195:3141/root/pypi/  --trusted-host 192.168.10.195 some-package
```

## 参考

https://www.zouht.com/3310.html
