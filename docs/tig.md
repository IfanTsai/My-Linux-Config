# tig 配置

经常使用 git ，每一个操作都是类似下面这种全部都敲一遍，会很累，很容易出错，而且记不住这么长的命令。
```sh
git commit -m "your awesome commit message"
```
所以有各种 git 工具加快经常性事件，比如
- [lazygit](https://github.com/jesseduffield/lazygit)
- [gitk](https://git-scm.com/docs/gitk/)
- [sublime merge](https://www.sublimemerge.com/)

tig 相比这些而言而言，代码开源，功能强大，界面简洁，可以集成到 vim 中使用

https://github.com/jonas/tig/blob/master/contrib/vim.tigrc

## TODO
- [ ] 测试 cherry pick
- [ ] 加载 Linux 实在是太慢了
- [ ] 还不如直接将 git.md 和 github.md 使用总结到一起