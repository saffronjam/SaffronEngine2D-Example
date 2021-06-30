#include "ProjectLayer.h"

namespace Se
{
void ProjectLayer::OnAttach(std::shared_ptr<BatchLoader>& loader)
{
	BaseLayer::OnAttach(loader);

	loader->Submit([this]()
	{
		_texture = TextureStore::Get("Editor/Saffron.png");
		_sprite = sf::Sprite(*_texture);
		_sprite.setScale(0.4f, 0.4f);
		_sprite.setPosition(-_sprite.getGlobalBounds().width / 2.0f, -_sprite.getGlobalBounds().height / 2.0f);
	}, "Loading Assets");
	loader->Submit([this]()
	{
		std::this_thread::sleep_for(std::chrono::milliseconds(1400));
	}, "Some more loading");
	loader->Submit([this]()
	{
		std::this_thread::sleep_for(std::chrono::milliseconds(1400));
	}, "A little bit more loading");
}

void ProjectLayer::OnDetach()
{
	BaseLayer::OnDetach();
}

void ProjectLayer::OnUpdate()
{
	BaseLayer::OnUpdate();
	_scene.Submit(_sprite);
}

void ProjectLayer::OnGuiRender()
{
	BaseLayer::OnGuiRender();

	if (ImGui::Begin("Project"))
	{
	}
	ImGui::End();
}

void ProjectLayer::OnRenderTargetResize(const sf::Vector2f& newSize)
{
	BaseLayer::OnRenderTargetResize(newSize);
}
}
