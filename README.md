## Общее
Привет! Это шаблонный проект, который включает в себя:
* Примеры архитектур VIPER и MVVM;
* Настроенный CI на fastlane + gitlab-ci;
* WebService с использованием Single(RxSwift);
* Часто используемые сервисы и менеджеры;
* Кастомизируемый бабл MapTextPinDrawer для отрисовки на картах;
* Часто используемые Extensions;
* Design-систему.


## UI Kit(Designe-system)

#### Для сборки UI компонента нужно инициализировать сборщик и создаваемый компонент, определить свойства компонента и собрать его. 
Для данных действий определены 2 метода:

* статический метод для начала сборки, который должен вернуть ссылку на сборщик, в котором произойдет создание компонента (startBuild);
* метод сборки компонента, который соберет создаваемый компонент и вернет на него ссылку (build);

```
protocol UIBuilderType where View: UIView {
    associatedtype View
     
    static func startBuild() -> Self
    func build() -> View
}
```

#### Для всех UI компонентов были выделены несколько свойств:
* translatesAutoresizingMaskIntoConstraints;
* backgroundColor;
* cornerRadius;
* borderWidth и borderColor;

```
protocol UIViewBuilderType: UIBuilderType {
    func useAutoLayout() -> Self
    func setBackgroundColor(_ color: UIColor?) -> Self
    func setCornerRadius(_ radius: CGFloat) -> Self
    func setBorder(width: CGFloat, color: UIColor) -> Self
}
```

#### Для дизайн системы можно выделить некоторые стили для каждого или некоторых UI компонентов. Для реализации стилей есть протокол StyleBuilder, который отвечает за применение стиля на компонент. 

Протокол StyleBuilder для применения стиля на компонент:

```
protocol StyleBuilder {
    associatedtype StyleType
     
    func setStyle(_ style: StyleType) -> Self
}
```

Реализация протокола StyleBuilder для UILabel: 
```
enum LabelStyle {
    case error
}
 
extension LabelBuilder: StyleBuilder {
    func setStyle(_ style: LabelStyle) -> Self {
        switch style {
            case .error:
                // применение стиля для UILabel
                label.textColor = color
                label.textAlignment = .left
                label.font = font
        }
    }
}
```

## Пример сборки UI компонента

#### Пример UI компонента UILabel с применением стиля. 
Стиль объединяет в себе цвет и шрифт label, который применяется во всём приложение.


```
errorLabel = LabelBuilder.startBuild()
                .useAutoLayout()
                .setStyle(.error)
                .setNumberOfLines(0)
                .build()
```

#### Пример UI компонента UILabel без стиля: 
```
valueLabel = LabelBuilder.startBuild()
            .useAutoLayout()
            .setFont(GlobusBrandBook.TextField.font)
            .setTextColor(Colors.placeholder)
            .setAlignment(.right)
            .setNumberOfLines(1)
            .build()
```

## Использование AutoLayout на UI компонентах

При использование anchor в коде необходимо вызывать метод useAutoLayout из протокола UIViewBuilderType. 

В некоторых сборщиках UI компонентов отсутсвует данный метод, так как внутри компонента translatesAutoresizingMaskIntoConstraints выставлен на false, либо внутри реализации компонента использован фреймворк SnapKit, который выставляет флаг на false при создание constraints. 

Если вы используете фреймворк SnapKit для создания constraints, вызов метода useAutoLayout избыточен.

Пример использования фреймворка SnapKit со сборщиком компонентов:

```
imageView = ImageViewBuilder.startBuild()
                .setContentMode(.scaleAspectFit)
                .build()
         
addSubview(imageView)
imageView.snp.makeConstraints { make in
    make.centerX.centerY.equalToSuperview()
    make.size.equalTo(sizeImage)
}
```

